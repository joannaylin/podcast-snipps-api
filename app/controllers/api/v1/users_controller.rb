class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    # after Spotify has user authorize application, user gets redirect to 
    # /api/v1/users (aka this method)
    # need to request refresh and access tokens from Spotify

    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: ENV['REDIRECT_URI'],
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }

    # use RestClient to create a POST request from Rails, using above body
    # auth_params contains the access and refresh tokens
    auth_response = RestClient.post("https://accounts.spotify.com/api/token", body)
    # convert the response.body of the post request for JSON
    auth_params = JSON.parse(auth_response.body)

    # assemble and send request to Spotify for user profile information
    # auth_params contains the access token
    header = {
      "Authorization": "Bearer #{auth_params["access_token"]}"
    }

    user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    # convert the response.body of the request for JSON
    user_params = JSON.parse(user_response.body)

    # create a new user based on response, or find existing user in database
    @user = User.find_or_create_by(username: user_params["id"], 
                        spotify_url: user_params["external_urls"]["spotify"], 
                        href: user_params["href"], 
                        uri: user_params["uri"], 
                        profile_img_url: user_params["images"][0]["url"])
    @user.update(access_token: auth_params["access_token"], refresh_token: auth_params["refresh_token"])

    # create and send JWT token for user
    payload = {user_id: @user.id}
    token = issue_token(payload)

    render json: {token: token, user: { username: @user.username, spotify_url: @user.spotify_url, profile_img_url: @user.profile_img_url, access: auth_params["access_token"] }}

  end

  def show
    user = User.find_by(username: current_user.username)
    render json: user
  end

  def podcast_search
    # check if the current user's access token needs to be refreshed, if so, method refreshes
    current_user.refresh_access_token

    # header includes the user's access token (required by spotify)
    header = {
      "Authorization": "Bearer #{current_user.access_token}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }

    # set up query params for search
    query_params = {
      q: params[:query],
      type: "show",
      market: "US",
      limit: 10,
    }

    search_response = RestClient.get("https://api.spotify.com/v1/search?#{query_params.to_query}", header)
    shows = JSON.parse(search_response.body)
    
    render json: {shows: shows, status: 200}

  end

  def podcast
    # check if the current user's access token needs to be refreshed, if so, method refreshes
    current_user.refresh_access_token

    # post request from frontend to backend passing in the params[:showId] (showId referencing show/podcast id)
    show_id = params[:showId]

    header = {
      "Authorization": "Bearer #{current_user.access_token}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }

    show_response = RestClient.get("https://api.spotify.com/v1/shows/#{show_id}?market=US", header)
    show_info = JSON.parse(show_response.body)

    render json: {show_info: show_info, status: 200}

  end

  def podcast_episodes
    # check if the current user's access token needs to be refreshed, if so, method refreshes
    current_user.refresh_access_token

    # post request from frontend to backend passing in the params[:showId] (showId referencing show/podcast id)
    show_id = params[:showId]

    header = {
      "Authorization": "Bearer #{current_user.access_token}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }

    query_params = {
      market: "US",
      limit: 10,
    }

    show_episodes = RestClient.get("https://api.spotify.com/v1/shows/#{show_id}/episodes?#{query_params.to_query}", header)
    show_episodes_info = JSON.parse(show_episodes.body)

    render json: {show_episodes_info: show_episodes_info, status: 200}

  end

end


