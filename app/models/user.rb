class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  has_many :comments
  has_many :episodes, through: :comments

  def access_token_expired?
    # returns true if access_token is older than 55 minutes, based on updated_at
    (Time.now - self.updated_at) > 3300
  end

  def refresh_access_token
    # check if user's access token has expired using above method
    if access_token_expired?
      # request a new access token using refresh token
      body = {
        grant_type: "refresh_token",
        refresh_token: self.refresh_token,
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV['CLIENT_SECRET']
      }

      # send request and user's access_token
      auth_response = RestClient.post("https://accounts.spotify.com/api/token", body)
      # parse for JSON
      auth_params = JSON.parse(auth_response)
      self.update(access_token: auth_params["access_token"])
    else
      puts "User's access token hasn't expired yet"
    end
  end

end
