require 'rails_helper'

RSpec.describe "QuestionValidation", type: :model do
  describe 'title' do
    describe 'presence: true' do
      it 'titleがblankの場合エラーになる' do
        question = Question.new(title: '', content: 'RSpecテストコンテント')
        question.valid?
        expect(question.errors[:title]).to include('を入力してください')
      end
    end
  end
end
