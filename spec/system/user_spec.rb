require 'rails_helper'
RSpec.describe 'ユーザ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)

    def owner
      visit new_user_session_path
      fill_in 'user[email]', with: 'piyo@piyo.com'
      fill_in 'user[password]', with: 'piyopiyo'
      find('.devise-btn').click
    end
  end

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
        find('.devise-btn').click
        expect(page).to have_content 'piyo'
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ログインせずにユーザ詳細画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移される' do
        visit user_path(@user)
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end
    context 'ログイン後、ログアウト操作を行った場合' do
      it 'ログアウトされる' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'piyo@piyo.com'
        fill_in 'user[password]', with: 'piyopiyo'
        find('.devise-btn').click
        find('#sidebar-btn').click
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
    context 'ゲストログインボタン押下' do
      it 'ユーザ詳細ページへ遷移される' do
        visit root_path
        find('.guest-btn').click
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'ゲスト'
      end
    end
    context '管理者ゲストログインボタン押下' do
      it 'ユーザ詳細ページへ遷移される' do
        visit root_path
        find('.admin-guest-btn').click
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content '管理者ゲスト'
      end
    end
  end
  describe 'ユーザ編集機能' do
    context 'ユーザ編集操作をした場合' do
      it 'ユーザ編集が完了し、ユーザ詳細画面へ遷移される' do
        owner
        click_on 'ユーザ編集'
        fill_in 'user[username]', with: 'テスト'
        fill_in 'user[email]', with: 'test@test.com'
        attach_file 'user[image]', "#{Rails.root}/spec/fixtures/test1.jpg"
        fill_in 'user[introduction]', with: '確認中です'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on '登録'
        expect(page).to have_content 'テスト'
        expect(page).to have_selector("img[src$='test1.jpg']")
        expect(page).to have_content '確認中です'
      end
    end
  end
end
