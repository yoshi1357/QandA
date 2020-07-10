require 'rails_helper'

RSpec.describe "UserValidation", type: :model do

  describe 'is valid with a name, email, password' do
    it 'name, email, passwordがあれば有効なこと' do
      user = User.new(
        name: 'John',
        email: 'abcde@email.com',
        password: 'Password1'
      )
      expect(user).to be_valid
    end
  end

  describe 'name' do

    describe 'presence: true' do
      it 'nameがblankの場合エラーになる' do
        user = User.new(name: '')
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end
    end
    describe 'length: {maximum: 10}' do
      it 'nameが11文字以上の場合エラーになる' do
        user = User.new(name: 'とりあえずテストで期待')
        user.valid?
        expect(user.errors[:name]).to include('は10文字以内で入力してください')
      end
    end

    describe 'uniqueness: true' do
      it 'nameが同じ既にある名前ならエラーになる' do
        User.create!(name: 'nakatsuka', email: 'test1@email.com', password: "Password1")
        user = User.new(name: 'nakatsuka', email: 'test2@email.com', password: "Password2")
        user.valid?
        expect(user.errors[:name]).to include('はすでに存在します')
      end
    end
  end

  describe 'email' do
    describe 'presence: true' do
      it 'emailがblankの場合エラーになる' do
        user = User.new(email: '')
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
    end
    describe 'uniqueness: { case_sensitive: false }' do
      it 'nameが同じ既にある名前ならエラーになる(大文字小文字区別しない)' do
        User.create!(name: 'nakatsuka1', email: 'test@email.com', password: "Password1")
        user = User.new(name: 'nakatsuka2', email: 'TEST@email.com', password: "Password2")
        user.valid?
        expect(user.errors[:email]).to include('はすでに存在します')
      end
    end
    describe 'format: { with: VALID_EMAIL_REGEX }' do
      it '正規表現にそぐわないとエラーになる（@なし）' do
        user = User.new(email: 'testemail.com')
        user.valid?
        expect(user.errors[:email]).to include('は不正な値です')
      end
    end
  end

  describe 'password' do
    describe 'presence: true' do
      it 'passwordがblankの場合エラーになる' do
        user = User.new(password: '')
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
    end
    describe 'format: { with: VALID_EMAIL_REGEX }' do
      it '正規表現にそぐわないとエラーになる（8文字未満）' do
        user = User.new(password: 'Pass1')
        user.valid?
        expect(user.errors[:password]).to include('半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります')
      end
    end
    describe 'format: { with: VALID_EMAIL_REGEX }' do
      it '正規表現にそぐわないとエラーになる（英大文字なし）' do
        user = User.new(password: 'password1')
        user.valid?
        expect(user.errors[:password]).to include('半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります')
      end
    end
    describe 'format: { with: VALID_EMAIL_REGEX }' do
      it '正規表現にそぐわないとエラーになる（英小文字なし）' do
        user = User.new(password: 'PASSWORD1')
        user.valid?
        expect(user.errors[:password]).to include('半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります')
      end
    end
    describe 'format: { with: VALID_EMAIL_REGEX }' do
      it '正規表現にそぐわないとエラーになる（数字なし）' do
        user = User.new(password: 'Password')
        user.valid?
        expect(user.errors[:password]).to include('半角英小文字、大文字、数字をそれぞれ1種類以上含む8文字以上100文字以下の必要があります')
      end
    end

  end
end
