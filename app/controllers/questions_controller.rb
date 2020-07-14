class QuestionsController < ApplicationController
  before_action :set_question, only:[:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index,]
  before_action :correct_user?, only: [:edit,:update,:destroy,]

  # PV数計測を:showへ 同じipアドレスからは重複して数えないように
  impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]

  PER = 10

  def index

    #Question.allの代わりにQuestion.page(params[:page]).per()が入る
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).sort_question(params[:target]).page(params[:page]).per(PER)

    #jsファイルにQuestion.allを渡す
    # gon.questions = Question.all
    @question = Question.find(params[:qid]) if params[:qid]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @answer = Answer.new

    @q = Question.ransack(params[:q])

    gon.answers_user_id = @question.answers.pluck(:user_id)
    gon.question_user_id = @question.user_id

    @views_questions = @question.impressions.size #PV数を取得
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    if @question.update(question_params)
      redirect_to question_path(@question),notice: "質問が投稿されました"
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