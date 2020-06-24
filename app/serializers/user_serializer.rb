class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :spotify_url, :href, :uri, :profile_img_url, :access_token, :refresh_token
end
