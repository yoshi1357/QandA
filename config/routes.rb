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
