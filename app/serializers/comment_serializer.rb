class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :user_id, :episode, :start_timestamp, :created_at, :updated_at

  belongs_to :episode
  belongs_to :user

end




