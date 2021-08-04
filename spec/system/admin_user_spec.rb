require 'rails_helper'
RSpec.describe '管理者機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }
  describe 'サイト管理機能' do
    context '管理者ユーザログイン後、ユーザ詳細画面にて管理者画面のボタンを押下した場合' do
      it 'サイト管理機能画面へ遷移される' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'piyo@piyo.com'
        fill_in 'user[password]', with: 'piyopiyo'
        find('.sign-in-btn').click
        click_on '管理者画面'
        sleep 1
        expect(page).to have_content 'サイト管理'
      end
    end
    context '一般ユーザの場合' do
      it 'ユーザ詳細画面に管理者画面のボタンが表示されていない' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'fuga@fuga.com'
        fill_in 'user[password]', with: 'fugafuga'
        find('.sign-in-btn').click
        expect(page).not_to have_content '管理者画面'
      end
    end
  end
end
