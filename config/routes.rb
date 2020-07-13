Rails.application.routes.draw do

  # get 'follows/create'
  # get 'follows/destroy'
  # devise_for :users
  # get 'questions/index'
  # get 'questions/show'
  # get 'questions/new'
  # get 'questions/edit'

  root 'questions#index'

  devise_for :users
  get '/inquiries/new' => 'inquiry#new'
  post '/inquiries' => 'inquiry#create'

  resources :users, only:[:index, :show] do
    resources :questions, only: [:edit, :update, :destroy]
    resource :follows, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end

  resources :questions do
    resources :answers, only: [:create]
  end

  post '/questions/:id/like_questions' => "like_questions#create"
  delete '/questions/:id/like_questions' => "like_questions#destroy"

end
