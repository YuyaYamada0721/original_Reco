require 'rails_helper'
RSpec.describe 'ストック機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @group = FactoryBot.create(:group)

    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)
    FactoryBot.create(:knowledge, member: @member, team: @team)

    visit new_user_session_path
    fill_in 'user[email]', with: 'piyo@piyo.com'
    fill_in 'user[password]', with: 'piyopiyo'
    find('.devise-btn').click
    click_on '個人記録・チーム記録へ'
    click_on 'テストチーム'
    click_on 'ナレッジ'
  end

  describe 'ストック登録機能' do
    context 'ストック登録操作をした場合' do
      it 'ストック登録が完了し、ストックボタンの表示が変わる' do
        click_on 'テストナレッジ'
        click_on 'ストック登録'
        expect(page).to have_content 'ストック解除'
        expect(page).to have_content 'ストックしました。'
      end
    end
  end
  describe 'ストック解除機能' do
    context 'ストック解除操作をした場合' do
      it 'ストック解除が完了し、ストックボタンの表示が変わる' do
        click_on 'テストナレッジ'
        click_on 'ストック登録'
        click_on 'ストック解除'
        expect(page).to have_content 'ストック登録'
        expect(page).to have_content 'ストックから外しました。'
      end
    end
  end
  describe 'ストック一覧機能' do
    context 'ストック登録をした場合' do
      it 'チームのメンバー詳細画面にストックしたナレッジが表示される' do
        click_on 'テストナレッジ'
        click_on 'ストック登録'
        visit team_member_path(@team, @member)
        expect(page).to have_content 'テストナレッジ'
      end
    end
    context 'ストック解除した場合' do
      it 'チームのメンバー詳細画面にストックしたナレッジが表示されない' do
        click_on 'テストナレッジ'
        click_on 'ストック登録'
        click_on 'ストック解除'
        visit team_member_path(@team, @member)
        expect(page).not_to have_content 'テストナレッジ'
      end
    end
    context 'ストックした項目を押下した場合' do
      it 'ナレッジの詳細へ遷移される' do
        click_on 'テストナレッジ'
        click_on 'ストック登録'
        visit team_member_path(@team, @member)
        click_on 'テストナレッジ'
        expect(page).to have_content 'ナレッジ名：テストナレッジ'
      end
    end
  end
end
