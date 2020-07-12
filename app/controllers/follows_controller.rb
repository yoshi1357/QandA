class FollowsController < ApplicationController
  before_action :set_question

  def create
    @follow = current_user.active_relationships.create(follower_id: params[:user_id])
  end

  def destroy
    @follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    @follow.destroy
  end


end
