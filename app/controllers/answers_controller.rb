class AnswersController < ApplicationController
  before_action :set_question, only:[:create, :show, :edit, :update, :destroy]
  before_action :set_latest_questions
  before_action :set_nores_questions
  before_action :set_nores


  def create
    @answer = Answer.new

    if @answer.update(answer_params)
      redirect_to question_path(@question),notice: 'Success!'
    else
      redirect_to question_path(@question),alert: 'invalid!'
    end
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update
    @answer = @question.answers.find(params[:id])

    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Success!'
    else
      flash[:alert] = 'Save Error!'
      render question_path(@question)
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])

    @answer.destroy
    redirect_to question_path(@question),notice: "Delete!"
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_latest_questions
      @latest_questions = Question.latest(5)
    end

    def set_nores_questions
      @nores_questions = Question.find(Answer.nores.keys)
    end

    def set_nores
      @nores = Answer.nores.values
    end

    def answer_params
      params.require(:answer).permit(:content, :name, :question_id)
    end
end
