Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/login", to: "auth#spotify_request"
      get "/auth", to: "auth#show"
      post "/search", to: "users#search"
      
      resources :users, only: [:create]
      resources :comments, only: [:index, :create, :update, :show, :destroy]
      resources :episodes, only: [:index, :create, :show]

    end
  end

end
