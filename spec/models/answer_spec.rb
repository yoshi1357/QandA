require 'rails_helper'

RSpec.describe 'AnswerValidation', type: :model do
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
