class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :content, presence: true

  # scope :nores, -> { left_joins(:question).group("question_id").order('count_question_id DESC').count("question_id") }

end
