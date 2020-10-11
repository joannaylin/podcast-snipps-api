class Api::V1::EpisodesController < ApplicationController

  def index
    episodes = current_user.episodes.uniq
    render json: episodes
  end

  def create
    if Episode.find_by(episode_name: params[:episode][:episode_name]) 
      episode = Episode.find_by(episode_name: params[:episode][:episode_name]) 
      episode.comments.create!(note: params[:comment][:note], start_timestamp: params[:comment][:start_timestamp], user: current_user)
      
      render json: episode
    else
      episode = Episode.create!(episode_params)
      episode.comments.create!(note: params[:comment][:note], start_timestamp: params[:comment][:start_timestamp], user: current_user)
      
      render json: episode
    end
  end

  def episode_search
    # check if the current user's access token needs to be refreshed, if so, method refreshes
    current_user.refresh_access_token

    # header includes the user's access token (required by spotify)
    header = {
      "Authorization": "Bearer #{current_user.access_token}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }

    episode_response = RestClient.get("https://api.spotify.com/v1/episodes/#{params[:episodeId]}?market=US", headers=header)
    episode = JSON.parse(episode_response.body)

    render json: {episode: episode, status: 200}
  end


  private

  def episode_params
    params.require(:episode).permit(:id, :episode_name, :duration, :description, :spotify_episode_id, :img_url, :show_name, :spotify_show_id)
  end

end
