require 'rails_helper'

RSpec.describe "QuestionValidation", type: :model do
  describe 'is valid with a title, content' do
    it 'title,contentがあれば有効なこと' do
      # 外部キーがある場合は、インスタンスから渡す
      user = User.new(
        name: 'John',
        email: 'abcde@email.com',
        password: 'Password1'
      )
      user.save
      question = Question.new(title: 'RSpecテストタイトル', content: 'RSpecテストコンテント', user_id: user.id)
      expect(question).to be_valid
    end
  end

  describe 'title' do
    describe 'presence: true' do
      it 'titleがblankの場合エラーになる' do
        question = Question.new(title: '', content: 'RSpecテストコンテント')
        question.valid?
        expect(question.errors[:title]).to include('を入力してください')
      end
    end
    describe 'length' do
      it 'titleが80文字以上だとエラーになる' do
        question = Question.new(title: "#{'RSpecテストタイトル' * 100}", content: 'RSpecテストコンテント')
        question.valid?
        expect(question.errors[:title]).to include('は80文字以内で入力してください')
      end
    end
  end

  describe 'content' do
    describe 'presence: true' do
      it 'contentがblankの場合エラーになる' do
        question = Question.new(title: 'RSpecテストタイトル', content: '')
        question.valid?
        expect(question.errors[:content]).to include('を入力してください')
      end
    end
    describe 'length' do
      it 'contentが1000文字以上だとエラーになる' do
        question = Question.new(title: 'RSpecテストタイトル', content: "#{'RSpecテストコンテント' * 1000}")
        question.valid?
        expect(question.errors[:content]).to include('は1000文字以内で入力してください')
      end
    end
  end
end
