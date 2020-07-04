class UsersController < ApplicationController
  before_action :set_latest_questions, :set_nores_questions, :set_nores

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_questions = @user.questions
    @user_answers = @user.answers
    @user_like_questions = @user.liked_questions
  end


end