class QuestionsController < ApplicationController
  before_action :set_question, only:[:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    if @question.save
      redirect_to root_path,notice: "Success!"
    else
      flash[:alert] = "Save error!"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
     if @question.update(question_params)
      redirect_to root_path,notice: "Success!"
     else
      flash[:alert] = "Save error!"
      render :edit
     end
  end

  def destroy
    @question.destroy
    redirect_to root_path,notice: "Success!"
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:name, :title, :content)
    end
end
