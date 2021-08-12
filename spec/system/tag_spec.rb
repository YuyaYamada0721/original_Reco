require 'rails_helper'
RSpec.describe 'タグ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @group = FactoryBot.create(:group)

    FactoryBot.create(:member, user: @user2, team: @team)
    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)
    FactoryBot.create(:tag, team: @team)

    def owner
      visit new_user_session_path
      fill_in 'user[email]', with: 'piyo@piyo.com'
      fill_in 'user[password]', with: 'piyopiyo'
      find('.devise-btn').click
      click_on '個人記録・チーム記録へ'
      click_on 'テストチーム'
      click_on 'タグ'
    end

    def general
      visit new_user_session_path
      fill_in 'user[email]', with: 'fuga@fuga.com'
      fill_in 'user[password]', with: 'fugafuga'
      find('.devise-btn').click
      click_on '個人記録・チーム記録へ'
      click_on 'テストチーム'
      click_on 'タグ'
    end
  end

  describe 'タグ登録機能' do
    context 'チームオーナーがタグ登録操作をした場合' do
      it 'タグ登録が完了し、タグ一覧画面へ遷移される' do
        owner
        click_on 'タグ登録'
        fill_in 'tag[name]', with: 'テストタグ1'
        click_on '登録'
        expect(page).to have_content 'テストタグ1'
        expect(page).to have_content 'タグを登録しました。'
      end
    end
    context 'チームオーナーが既に登録されているタグ名で登録操作をした場合' do
      it '登録できない' do
        owner
        click_on 'タグ登録'
        fill_in 'tag[name]', with: 'テストタグ1'
        click_on '登録'
        click_on 'タグ登録'
        fill_in 'tag[name]', with: 'テストタグ１'
        click_on '登録'
        expect(page).to have_content '保存できませんでした。既に存在するタグ名です。'
        expect(page).to have_content 'タグ登録'
      end
    end
    context 'オーナー以外がタグ一覧画面へ遷移した場合' do
      it 'タグ登録ボタンが表示されない' do
        general
        expect(page).not_to have_content 'タグ登録'
      end
    end
    context 'オーナーでないかつURLに直接newと入力しアクセスしようとした場合' do
      it 'タグ一覧画面へリダイレクトされる' do
        general
        visit new_team_tag_path(@team)
        expect(page).to have_content 'タグ一覧'
        expect(page).to have_content 'チームのオーナーでないとアクセスできません。'
      end
    end
  end
  describe 'タグ削除機能' do
    context 'チームオーナーがタグ削除操作をした場合' do
      it 'タグ削除が完了する' do
        owner
        click_on '削除'
        page.accept_alert
        expect(page).not_to have_content 'テストタグ'
      end
    end
    context 'オーナー以外がタグ一覧画面へ遷移した場合' do
      it 'タグ削除ボタンが表示されない' do
        general
        expect(page).not_to have_content '削除'
      end
    end
  end
end
