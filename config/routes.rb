Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#top"
  get '/tutorial', to: 'static_pages#tutorial'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments, only: %i[create], shallow: true
    collection do
      get :bookmarks
      get :scheduled
      get :received
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resource :profile, only: %i[show edit update]

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
