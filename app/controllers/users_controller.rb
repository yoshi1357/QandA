class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_questions = @user.questions
    @user_answers = @user.answers
    @user_like_questions = @user.liked_questions
    @user_follows = User.find(@user.active_relationships.pluck(:follower_id))
    @user_followers = User.find(@user.passive_relationships.pluck(:following_id))
  end


end