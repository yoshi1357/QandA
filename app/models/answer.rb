class Answer < ApplicationRecord
  belongs_to :question
  validates :name, presence: true
  validates :content, presence: true

  scope :nores, -> { joins(:question).group("question_id").order('count_question_id DESC').count("question_id") }

end
