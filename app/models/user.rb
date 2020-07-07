class User < ApplicationRecord
  # アソーシエーション
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :like_question, dependent: :destroy
  has_many :liked_questions, through: :like_question, source: :question

  # バリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,100}+\z/

  validates :name, { presence: true, uniqueness: { case_sensitive: false } }
  validates :email, { presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX } }
  #半角英小文字大文字数字をそれぞれ1種類以上含む8文字以上100文字以下
  validates :password, { format: { with: VALID_PASSWORD_REGEX ,
  message: "半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります" }, confirmation: true }




  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
        # :validatable 自分でバリデーションかけたくてコメントアウト
end
