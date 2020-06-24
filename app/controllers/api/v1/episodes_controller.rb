class Api::V1::EpisodesController < ApplicationController

  def index
    p "this is the index action"
    episodes = Episode.all
    render json: episodes
  end

  def create
    p "this is the create action"
    episode = Episode.create!(episode_params)
    render json: episode
  end

  def show
    p "this is the show action"
    episode = Episode.find(params[:id])
    render json: episode
  end

  private

  def episode_params
    params.require(:episode).permit(:id, :episode_name, :duration, :description, :spotify_episode_id, :img_url, :show_name, :spotify_show_id)
  end

end
