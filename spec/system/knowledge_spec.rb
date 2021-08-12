require 'rails_helper'
RSpec.describe 'ナレッジ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @member2 = FactoryBot.create(:member, user_id: @user2.id, team_id: @team.id)
    @group = FactoryBot.create(:group)
    @knowledge = FactoryBot.create(:knowledge3, member_id: @member2.id, team_id: @team.id)

    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)
    FactoryBot.create(:knowledge, member: @member, team: @team)
    FactoryBot.create(:knowledge2, member: @member2, team: @team)

    visit new_user_session_path
    fill_in 'user[email]', with: 'piyo@piyo.com'
    fill_in 'user[password]', with: 'piyopiyo'
    find('.devise-btn').click
    click_on '個人記録・チーム記録へ'
    click_on 'テストチーム'
    click_on 'ナレッジ'
  end

  describe 'ナレッジ登録機能' do
    context 'ナレッジ登録操作をした場合' do
      it 'ナレッジ登録が完了し、ナレッジ一覧画面へ遷移される' do
        click_on 'ナレッジ登録'
        fill_in 'knowledge[name]', with: 'テストナレッジ'
        click_on '登録'
        expect(page).to have_content 'テストナレッジ'
        expect(page).to have_content 'ナレッジを登録しました。'
      end
    end
  end
  describe 'ナレッジ詳細機能' do
    context 'ナレッジ詳細操作をした場合' do
      it 'ナレッジの詳細画面へ遷移される' do
        click_on 'テストナレッジ'
        expect(page).to have_content 'テストナレッジ'
      end
    end
  end
  describe 'ナレッジ編集機能' do
    context 'ナレッジ編集操作をした場合' do
      it 'ナレッジ編集ができる' do
        click_on 'テストナレッジ'
        click_on 'ナレッジ編集'
        fill_in 'knowledge[name]', with: 'ナレッジ編集機能テスト'
        click_on '登録'
        expect(page).to have_content 'ナレッジ編集機能テスト'
        expect(page).to have_content 'ナレッジを編集しました。'
      end
    end
    context 'ナレッジ作成者でない場合' do
      it 'ナレッジ編集ボタンが表示されない' do
        click_on 'fugaナレッジ'
        expect(page).not_to have_content 'ナレッジ編集'
      end
    end
    context 'ナレッジ作成者でないかつURLに直接editと入力しアクセスしようとした場合' do
      it 'ナレッジの一覧画面へリダイレクトされる' do
        visit edit_team_knowledge_path(@team, @knowledge)
        expect(page).to have_content 'ナレッジ一覧'
        expect(page).to have_content 'ナレッジの作成者でないとアクセスできません。'
      end
    end
  end
  describe 'ナレッジ削除機能' do
    context 'ナレッジ削除操作をした場合' do
      it 'ナレッジ削除ができる' do
        click_on 'テストナレッジ'
        click_on 'ナレッジ編集'
        click_on '削除'
        page.accept_alert
        expect(page).not_to have_content 'テストナレッジ'
        expect(page).to have_content 'ナレッジを削除しました。'
      end
    end
  end
  describe 'ナレッジ検索機能' do
    context 'ナレッジの検索操作をした場合' do
      it '検索したナレッジが表示される' do
        fill_in 'q[name_cont]', with: 'fugaナレッジ'
        click_on '検索'
        expect(page).to have_content 'fugaナレッジ'
        expect(page).not_to have_content 'テストナレッジ'
      end
    end
  end
end
