Rails.application.routes.draw do
  root 'feed#show'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/sign_up', to: 'users#new', as: :sign_up
  post '/sign_up', to: 'users#create'
end
