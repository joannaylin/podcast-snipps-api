class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :episode_name, :duration, :description, :spotify_episode_id, :img_url, :show_name, :spotify_show_id

  has_many :comments
  has_many :users, through: :comments
end

