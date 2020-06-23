class QuestionsController < ApplicationController
  before_action :set_question, only:[:show, :edit, :update, :destroy]
  before_action :set_latest_questions, :set_nores_questions, :set_nores

  before_action :authenticate_user!, except: [:index,]
  before_action :correct_user?, only: [:edit,:update,:destroy,]


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
      flash[:alert] = "質問の投稿に失敗しました"
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
      flash[:alert] = "質問の更新に失敗しました"
      render :edit
     end
  end

  def destroy
    @question.destroy
    redirect_to root_path,notice: "質問を削除しました"
  end

  private

    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end

end