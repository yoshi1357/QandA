class QuestionsController < ApplicationController
  before_action :set_question, only:[:show, :edit, :update, :destroy]
  before_action :set_latest_questions
  before_action :set_nores_questions
  before_action :set_nores

  before_action :authenticate_user!, except: [:index, :show]

  PER = 10

  def index
    #Question.allの代わりにQuestion.page(params[:page]).per()が入る
    @questions = Question.search(params[:word]).page(params[:page]).per(PER).order(created_at: "DESC")
    @search_count = Question.search(params[:word]).count
    @users = User.all

  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    if @question.update(question_params)
      redirect_to root_path,notice: "質問が投稿されました"
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
      redirect_to root_path,notice: "質問が更新されました"
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

    def set_latest_questions
      @latest_questions = Question.latest(5)
    end

    def set_nores_questions
      @nores_questions = Question.find(Answer.nores.keys)
    end

    def set_nores
      @nores = Answer.nores.values
    end

    def question_params
      params.require(:question).permit(:name, :title, :content, :user_id)
    end

end