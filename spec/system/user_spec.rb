require 'rails_helper'
RSpec.describe 'ユーザ機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe 'ユーザ登録機能' do
    context 'ユーザ登録操作をした場合' do
      it 'ユーザ登録が完了し、ユーザ詳細画面へ遷移される' do
        visit new_user_registration_path
        fill_in 'user[username]', with: 'hoge'
        fill_in 'user[email]', with: 'hoge@hoge.com'
        fill_in 'user[password]', with: 'hogehoge'
        fill_in 'user[password_confirmation]', with: 'hogehoge'
        click_on 'アカウント登録'
        expect(page).to have_content 'hoge'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end
  describe 'ユーザログイン機能' do
    context 'ユーザログイン操作をした場合' do
      it 'ログインが完了し、ユーザ詳細画面へ遷移される'do
        visit new_user_session_path
        fill_in 'user[email]', with: 'piyo@piyo.com'
        fill_in 'user[password]', with: 'piyopiyo'
        find('.sign-in-btn').click
        expect(page).to have_content 'piyo'
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ログインせずにユーザ詳細画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移される' do
        visit user_path(user)
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end
    context 'ログイン後、ログアウト操作を行った場合' do
      it 'ログアウトされる' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'piyo@piyo.com'
        fill_in 'user[password]', with: 'piyopiyo'
        find('.sign-in-btn').click
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
end
