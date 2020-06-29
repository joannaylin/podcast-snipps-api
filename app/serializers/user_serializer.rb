class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :spotify_url, :profile_img_url, :href, :uri

  has_many :comments
  has_many :episodes, through: :comments

end 

