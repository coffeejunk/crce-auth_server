Rails.application.routes.draw do
  root 'home#index'

  get '/verify/:provider', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/sessions/current', to: 'sessions#current'
end
