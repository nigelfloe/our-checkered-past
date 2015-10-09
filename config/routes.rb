Rails.application.routes.draw do
  resources :boards, only: [:create]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  root 'home#index' #landing page/sign up

  get '/game', to: 'game#index'

  get '/leaderboard', to: 'user#index'


end
