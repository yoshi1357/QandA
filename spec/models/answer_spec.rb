require 'rails_helper'

RSpec.describe 'AnswerValidation', type: :model do
  describe 'is valid with a content' do
    it 'contentがあれば有効なこと' do
      # 外部キーがある場合は、インスタンスから渡す
      user = User.new(
        name: 'John',
        email: 'abcde@email.com',
        password: 'Password1'
      )
      user.save
      question = Question.new(title: 'RSpecテストタイトル',
        content: 'RSpecテストコンテント',
        user_id: user.id
      )
      question.save
      answer = Answer.new(content: 'RSpecテストコンテント', user_id: user.id, question_id: question.id)
      expect(answer).to be_valid
    end
  end

  describe 'content' do
    describe 'presence: true' do
      it 'contentがblankの場合エラーになる' do
        answer = Answer.new(content: '', question_id: 1, user_id: 1)
        answer.valid?
        expect(answer.errors[:content]).to include('を入力してください')
      end
    end

    describe 'length' do
      it 'contentが1000文字以上だとエラーになる' do
        answer = Answer.new(content: "#{'RSpecテストコンテント' * 100}", question_id: 1, user_id: 1)
        answer.valid?
        expect(answer.errors[:content]).to include('は1000文字以内で入力してください')
      end
    end
  end
end
