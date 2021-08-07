require 'rails_helper'
RSpec.describe 'タグ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @group = FactoryBot.create(:group)

    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)
    FactoryBot.create(:tag, team: @team)

    visit new_user_session_path
    fill_in 'user[email]', with: 'piyo@piyo.com'
    fill_in 'user[password]', with: 'piyopiyo'
    find('.devise-btn').click
    click_on '個人記録・チーム記録へ'
    click_on 'テストチーム'
    click_on 'タグ'
  end

  describe 'タグ登録機能' do
    context 'タグ登録操作をした場合' do
      it 'タグ登録が完了し、タグ一覧画面へ遷移される' do
        click_on 'タグ登録'
        fill_in 'tag[name]', with: 'テストタグ'
        click_on '登録'
        expect(page).to have_content 'テストタグ'
        expect(page).to have_content 'タグを登録しました。'
      end
    end
  end
  describe 'タグ削除機能' do
    context 'タグ削除操作をした場合' do
      it 'タグ削除が完了する' do
        click_on '削除'
        page.accept_alert
        expect(page).not_to have_content 'テストタグ'
      end
    end
  end
end
