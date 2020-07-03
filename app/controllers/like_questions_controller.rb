class LikeQuestionsController < ApplicationController
   before_action :set_question

  def create
    @like_question = LikeQuestion.create(user_id: current_user.id, question_id: @question.id)

  end

  def destroy
    @like_question = LikeQuestion.find_by(user_id: current_user.id, question_id: @question.id)
    @like_question.destroy
  end
end
