class AnswersController < ApplicationController


  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new

    if @answer.update(answer_params)
      redirect_to question_path(@question),notice: '回答を投稿しました'
    else
      flash[:alert] = '回答の投稿に失敗しました'
      render template: "questions/show"
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
