class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:spotify_request]

  def spotify_request
    # user clicked "login" button, assemble get request to
    # Spotify to have user authorize application

    query_params = {
      client_id: ENV['CLIENT_ID'],
      response_type: "code",
      redirect_uri: ENV['REDIRECT_URI'],
      scope: "user-read-playback-position",
      show_dialog: true
    }

    url = "https://accounts.spotify.com/authorize"

    # .to_query is a ruby method that returns string suitable for a URL query string
    # redirect to Spotify's authorization page, which contains the query params above
    # query params includes scopes the app is requesting
    redirect_to "#{url}?#{query_params.to_query}"
  end

  def show
    # if application_controller#authorized is successful, return data for the user
    render json: { 
      username: current_user.username, 
      spotify_url: current_user.spotify_url, 
      profile_img_url: current_user.profile_img_url
    }
  end

end
