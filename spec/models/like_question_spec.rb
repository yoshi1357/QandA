require 'rails_helper'

RSpec.describe "LikeQuestionValidation", type: :model do
  let(:user_params) { { name: 'John', email: 'abcde@email.com', password: 'Password1' } }
  let(:question_params) { { title: 'TestTitle', content: 'TestContent' } }

  before do
    @user = User.new(**user_params)
    @user.save

    @question = Question.new(**question_params, user_id: @user.id)
    @question.save
  end
  describe 'is valid with a question_id, user_id' do
    it 'user_idとquestion_idがあれば有効なこと' do
      like_question = LikeQuestion.new(user_id: @user.id, question_id: @question.id)
      expect(like_question).to be_valid
    end
  end
  describe 'validates_uniqueness_of :question_id, scope: :user_id' do
    it '同じuser_id,question_idの組はエラーになること(一意性)' do
      like_question1 = LikeQuestion.new(user_id: @user.id, question_id: @question.id)
      like_question1.save
      like_question2 = LikeQuestion.new(user_id: @user.id, question_id: @question.id)

      expect(like_question2.valid?).to eq(false)
    end
  end
end
