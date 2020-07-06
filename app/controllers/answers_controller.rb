class AnswersController < ApplicationController


  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new

    if @answer.update(answer_params)
      redirect_to question_path(@question),notice: '回答を投稿しました'
    else
      redirect_to question_path(@question),alert: '回答の投稿に失敗しました'
    end
  end

  # def edit
  #   @answer = @question.answers.find(params[:id])
  # end

  # def update
  #   @answer = @question.answers.find(params[:id])

  #   if @answer.update(answer_params)
  #     redirect_to question_path(@question), notice: '回答を編集しました'
  #   else
  #     flash[:alert] = '回答の編集を失敗しました'
  #     render question_path(@question)
  #   end
  # end

  # def destroy
  #   @answer = @question.answers.find(params[:id])

  #   @answer.destroy
  #   redirect_to question_path(@question),notice: "回答を消去しました"
  # end

  private

    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
