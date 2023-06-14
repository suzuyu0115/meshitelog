Rails.application.routes.draw do
  root 'tops#index'

  get '/tops', to: 'tops#index'
end
