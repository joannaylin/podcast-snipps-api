Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/login", to: "auth#spotify_request"
      get "/auth", to: "auth#show"
    
      resources :users, only: [:create]
      post "/podcast_search", to: "users#podcast_search"
      post "/podcast", to: "users#podcast"
      post "/podcast_episodes", to: "users#podcast_episodes"
      
      resources :comments, only: [:index, :create, :update, :show, :destroy]
      resources :episodes, only: [:index, :create, :show]
      post "/episode_search", to: "episodes#episode_search"

    end
  end

end
