class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized

  def create
    # after Spotify has user authorize application, user gets redirect to 
    # /api/v1/users (aka this method)
    # need to request refresh and access tokens from Spotify
    p "*****YOU'VE HIT USERS#CREATE*****"
    
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: ENV['REDIRECT_URI'],
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
    # use RestClient to create a POST request from Rails, using above body
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
    @user = User.find_or_create_by(username: user_params["id"], spotify_url: user_params["external_urls"]["spotify"], href: user_params["href"], uri: user_params["uri"], profile_img_url: user_params["images"][0]["url"])
    @user.update(access_token: auth_params["access_token"], refresh_token: auth_params["refresh_token"])

    # create and send JWT token for user
    # add another layer of authentication
    payload = {user_id: @user.id}
    token = issue_token(payload)

    render json: {jwt: token, user: { username: @user.username, spotify_url: @user.spotify_url, profile_img_url: @user.profile_img_url}}

  end

end
