class LikeQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :user
  # 同じ組の値を１つしか持てない
  validates_uniqueness_of :question_id, scope: :user_id
end
