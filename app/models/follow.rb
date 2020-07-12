class Follow < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  # 同じ組の値を１つしか持てない
  validates_uniqueness_of :following_id, scope: :follower_id
end
