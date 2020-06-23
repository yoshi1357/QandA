class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :search, -> (word){ word ? where(['title LIKE ?', "%#{word}%"]) : all }

  scope :latest, -> (n){ order(created_at: "DESC").limit(n) if count > n }

  # def self.search(word) #self.はUser.を意味する
  #   if word
  #     where(['title LIKE ?', "%#{word}%"]) #検索とuseanameの部分一致を表示。
  #   else
  #     all #全て表示させる
  #   end
  # end
end
