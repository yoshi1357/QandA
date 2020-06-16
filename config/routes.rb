Rails.application.routes.draw do
  # devise_for :users
  # get 'questions/index'
  # get 'questions/show'
  # get 'questions/new'
  # get 'questions/edit'

  root 'questions#index'
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  #   :passwords => 'users/passwords'
  # }

  devise_for :users

  resources :users do
    # member do
    #   get 'questins/new'
    #   get 'answers/new'
    # end
    resources :questions, only: [:new, :create, :edit, :update, :destroy]
    resources :answers, only:  [:new, :create, :edit, :update, :destroy]
  end

  resources :questions, only: [:index, :show] do
    resources :answers, only: [:index, :show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
