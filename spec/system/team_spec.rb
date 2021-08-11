require 'rails_helper'
RSpec.describe 'チーム機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @team2 = FactoryBot.create(:team2, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @member2 = FactoryBot.create(:member, user_id: @user.id, team_id: @team2.id)
    @group = FactoryBot.create(:group)

    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:team2, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)

    visit new_user_session_path
    fill_in 'user[email]', with: 'piyo@piyo.com'
    fill_in 'user[password]', with: 'piyopiyo'
    find('.devise-btn').click
    click_on '個人記録・チーム記録へ'
  end

  describe 'チーム登録機能' do
    context 'チーム登録操作をした場合' do
      it 'チーム登録が完了し、チーム一覧画面へ遷移される' do
        click_on 'チーム登録'
        fill_in 'team[name]', with: 'テストチーム１'
        click_on '登録'
        expect(page).to have_content 'テストチーム１'
        expect(page).to have_content 'チームを登録しました。'
      end
    end
  end
  describe 'チーム詳細機能' do
    context 'チーム詳細操作をした場合' do
      it 'チームの詳細画面へ遷移される' do
        click_on 'テストチーム'
        expect(page).to have_content 'テストチーム'
      end
    end
  end
  describe 'チーム編集機能' do
    context 'チーム編集操作をした場合' do
      it 'チーム編集ができる' do
        click_on 'テストチーム'
        click_on 'チーム編集'
        fill_in 'team[name]', with: '編集テスト'
        click_on '登録'
        expect(page).to have_content '編集テスト'
      end
    end
  end
  describe 'チーム削除機能' do
    context 'チーム削除操作をした場合' do
      it 'チーム削除ができる' do
        click_on 'テストチーム'
        click_on 'チーム編集'
        click_on 'チーム削除'
        page.accept_alert
        expect(page).not_to have_content 'テストチーム'
      end
    end
  end
  describe 'チーム招待機能' do
    context 'チームへの招待操作をした場合' do
      it 'チームに招待できる' do
        click_on 'テストチーム'
        click_on 'チーム編集'
        fill_in 'team[email]', with: 'fuga@fuga.com'
        click_on '招待'
        expect(page).to have_content 'fuga'
      end
    end
  end
  describe 'チーム脱退機能' do
    context 'チーム脱退操作をした場合' do
      it 'チームを脱退させる事ができる' do
        click_on 'テストチーム'
        click_on 'チーム編集'
        fill_in 'team[email]', with: 'fuga@fuga.com'
        click_on '招待'
        click_on 'チーム編集'
        click_on 'チーム脱退'
        page.accept_alert
        expect(page).not_to have_content 'fuga'
        expect(page).to have_content 'メンバーを脱退させました。'
      end
    end
  end
  describe 'オーナー権限譲渡機能' do
    context 'オーナー権限譲渡操作をした場合' do
      it 'オーナー権限を譲渡させる事ができる' do
        click_on 'テストチーム'
        click_on 'チーム編集'
        fill_in 'team[email]', with: 'fuga@fuga.com'
        click_on '招待'
        click_on 'チーム編集'
        click_on 'オーナー権限譲渡'
        expect(page).to have_content 'チームオーナーを交代しました。'
        expect(page).to have_content 'fuga'
      end
    end
  end
  describe 'チーム検索機能' do
    context 'チームの検索操作をした場合' do
      it '検索したチームが表示される' do
        fill_in 'q[name_cont]', with: 'fugaチーム'
        click_on '検索'
        expect(page).to have_content 'fugaチーム'
        expect(page).not_to have_content 'テストチーム'
      end
    end
  end
end
