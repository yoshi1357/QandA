class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ransack_q

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
 	  devise_parameter_sanitizer.permit(:sign_up, keys: [:image]) # 新規登録時(sign_up時)にimageというキーのパラメーターを追加で許可する

    devise_parameter_sanitizer.permit(:account_update, keys: [:name]) # 編集時(edit時)にnameというキーのパラメーターを追加で許可する
 	  devise_parameter_sanitizer.permit(:account_update, keys: [:image]) # 編集時(edit時)にimageというキーのパラメーターを追加で許可する
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_latest_questions
    @latest_questions = Question.latest(5)
  end

  def set_ransack_q
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true)
  end

  # def set_nores_questions
  #   @nores_questions = Question.find(Answer.nores.keys)
  # end

  # def set_nores
  #   @nores = Answer.nores.values
  # end

  def correct_user?
    unless params[:user_id].to_i == current_user.id
      redirect_to root_path
    end
  end

end
