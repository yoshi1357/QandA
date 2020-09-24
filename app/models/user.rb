class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
        # :validatable 自分でバリデーションかけたくてコメントアウト

  # アソーシエーション
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :like_question, dependent: :destroy
  has_many :liked_questions, through: :like_question, source: :question
  has_many :active_relationships, class_name: "Follow", foreign_key: :following_id
  has_many :following, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Follow", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # バリデーション

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,100}+\z/

  validates :name, { presence: true, length: {maximum: 10}, uniqueness: true }
  validates :email, { presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX } }
  #半角英小文字大文字数字をそれぞれ1種類以上含む8文字以上100文字以下
  validates :password, { presence: true, format: { with: VALID_PASSWORD_REGEX ,
  message: "半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります" }, confirmation: true }

  mount_uploader :image, ImageUploader


end
