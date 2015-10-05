Rails.application.routes.draw do
  resources :boards, only: [:create]

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }


  root 'home#index' #landing page/sign up

  get '/game', to: 'game#index'
  # get '/game/new', to: 'game#new'
  # post '/game', to: 'game#create'

  get '/leaderboard', to: 'user#index'


end
