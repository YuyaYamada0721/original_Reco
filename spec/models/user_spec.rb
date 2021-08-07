require 'rails_helper'
RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(username: '', email: 'user@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザの名前が30字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(username: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDE', email: 'user@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザの名前が30字の場合' do
      it 'バリデーションが通る' do
        user = User.new(username: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCD', email: 'user@example.com', password: 'password')
        expect(user).to be_valid
      end
    end
    context 'ユーザのメールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(username: 'user', email: '', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのメールアドレスが255字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(username: 'user',
                        email: 'ABC@EFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQR.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのメールアドレスが255字の場合' do
      it 'バリデーションが通る' do
        user = User.new(username: 'user',
                        email: 'ABC@EFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQ.com', password: 'password')
        expect(user).to be_valid
      end
    end
    context 'ユーザのメールアドレスのフォーマットが不正の場合' do
      it 'バリデーションが引っかかる' do
        user = User.new(username: 'user', email: 'user.example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのパスワードが空の場合' do
      it 'バリデーションが引っかかる' do
        user = User.new(username: 'user', email: 'user@example.com', password: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのパスワードが6字未満の場合' do
      it 'バリデーションが引っかかる' do
        user = User.new(username: 'user', email: 'user@example.com', password: 'passw')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのパスワードが255字を超える場合' do
      it 'バリデーションが引っかかる' do
        user = User.new(username: 'user', email: 'user@example.com',
                        password: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUV')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザのパスワードが255字の場合' do
      it 'バリデーションが通る' do
        user = User.new(username: 'user', email: 'user@example.com',
                        password: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTU')
        expect(user).to be_valid
      end
    end
    context 'ユーザの自己紹介が200字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(username: 'user', email: 'user@example.com', password: 'password',
                        introduction: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRS')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザの自己紹介が200字の場合' do
      it 'バリデーションが通る' do
        user = User.new(username: 'user', email: 'user@example.com', password: 'password',
                        introduction: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQR')
        expect(user).to be_valid
      end
    end
    context 'ユーザの名前、メールアドレス、パスワードが入力されている場合' do
      it 'バリデーションが通る' do
        user = User.new(username: 'user', email: 'user@example.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end
end
