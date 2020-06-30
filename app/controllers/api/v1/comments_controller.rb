class Api::V1::CommentsController < ApplicationController

  # def index
  #   comments = Comment.all
  #   render json: comments
  # end

  # def create
  #   p "this is the create action"
  #   render json: comment
  # end

  # def show
  #   comment = Comment.find(params[:id])
  #   render json: comment
  # end

  def update
    comment = Comment.find(params[:id])
    comment.update!(comment_params)
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :user_id, :episode_id, :note, :start_timestamp)
  end

end
