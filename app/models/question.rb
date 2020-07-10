class Question < ApplicationRecord
  # アソーシエーション
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :like_question
  has_many :liked_users, through: :like_question, source: :user

  #questionのPV数の計測
  is_impressionable counter_cache: true

  # バリテーション
  validates :title, :content, presence: true
  validates :title, length: {maximum: 80}
  validates :content, length: {maximum: 1000}

  # 並べ替えのためのscope
  # scope :latest, -> (n){ order(created_at: "DESC").limit(n) if count > n }
  scope :nores, -> { left_joins(:answers).select('questions.*, count(answers.question_id) as count_question_id').group("answers.question_id").order('count_question_id DESC')}
  scope :nofav, -> { left_joins(:like_question).select('questions.*, count(like_questions.question_id) as count_question_id').group("like_questions.question_id").order('count_question_id DESC') }

  # 並べ替え用
  def self.sort_question(target)
    case target

    when 'answers' then
      nores

    when 'no-answers' then
      Question.left_joins(:answers).where("answers.question_id": nil)

    when 'favorites' then
      nofav

    when 'no-favorites' then
      Question.left_joins(:like_question).where("like_questions.question_id": nil)

    else
      all
    end
  end




end
