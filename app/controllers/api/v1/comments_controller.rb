class Api::V1::CommentsController < ApplicationController

  def index
    p "this is the index action"
    comments = Comment.all
    render json: comments
  end

  def create
    p "this is the create action"
    render json: comment
  end

  def show
    p "this is the show action"
    comment = Comment.find(params[:id])
    render json: comment
  end

  def update
    p "this is the update action"
    comment = Comment.find(params[:id])
    comment.update!(comment_params)
    render json: comment
  end

  def destroy
    p "this is the destroy action"
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :user_id, :episode_id, :note, :start_timestamp)
  end

end
