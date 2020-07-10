Rails.application.routes.draw do

  # devise_for :users
  # get 'questions/index'
  # get 'questions/show'
  # get 'questions/new'
  # get 'questions/edit'

  root 'questions#index'
  get '/inquiries/new' => 'inquiry#new'
  post '/inquiries' => 'inquiry#create'
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  #   :passwords => 'users/passwords'
  # }

  devise_for :users

  resources :users, only:[:index, :show] do
    resources :questions, only: [:edit, :update, :destroy]
  end

  resources :questions do
    resources :answers, only: [:create]
  end

  post '/questions/:id/like_questions' => "like_questions#create"
  delete '/questions/:id/like_questions' => "like_questions#destroy"

  #   # 個人での利用のもの
  #   resources :questions, only: [:edit, :update, :destroy]
  #   resources :answers, only:  [:edit, :update, :destroy]
  # end

  # # 誰でも or 会員ならだれでも
  # resources :questions, only: [:index, :new, :show, :create] do
  #   resources :answers, only: [:new , :create]
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
