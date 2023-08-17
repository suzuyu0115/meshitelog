Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#top"
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  resource :user, only: %i[new create destroy]

  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :top_rated
      get :bookmarks
      get :scheduled
      get :received
      get :search_tags
    end
  end

  resources :bookmarks, only: %i[create destroy]

  resource :profile, only: %i[show edit update]

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
