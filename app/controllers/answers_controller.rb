class AnswersController < ApplicationController


  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new

    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@question), notice: '回答を投稿しました' }
        format.js #answers/create.js.erbを呼び出す
      else
        format.html { render template: "questions/show", alert: '回答の投稿に失敗しました' }
        format.js { render :errors }
      end
    end

  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])

    if @answer.destroy
      redirect_to question_path(@question), notice: '回答を削除しました'
    end

  end

  private

    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
