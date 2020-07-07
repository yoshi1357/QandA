class Answer < ApplicationRecord
  # アソーシエーション
  belongs_to :question
  belongs_to :user

  # バリテーション
  validates :content, presence: true
  validates :content, length: {maximum: 1000}

end
