require 'rails_helper'
RSpec.describe 'ティップ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @team = FactoryBot.create(:team, user_id: @user.id, owner_id: @user.id)
    @member = FactoryBot.create(:member, user_id: @user.id, team_id: @team.id)
    @group = FactoryBot.create(:group)
    @knowledge = FactoryBot.create(:knowledge, member_id: @member.id, team_id: @team.id)
    @tag = FactoryBot.create(:tag, team_id: @team.id)
    @tip2 = FactoryBot.create(:tip2, knowledge_id: @knowledge.id, member_id: @member.id, team_id: @team.id)

    FactoryBot.create(:team, user: @user, owner: @user)
    FactoryBot.create(:group_member, member: @member, group: @group)
    FactoryBot.create(:tip, knowledge: @knowledge, member: @member, team: @team)
    # FactoryBot.create(:tip2, knowledge: @knowledge, member: @member, team: @team)
    FactoryBot.create(:tagging, tip: @tip2, tag: @tag)

    visit new_user_session_path
    fill_in 'user[email]', with: 'piyo@piyo.com'
    fill_in 'user[password]', with: 'piyopiyo'
    find('.devise-btn').click
    click_on '個人記録・チーム記録へ'
    click_on 'テストチーム'
    click_on 'ナレッジ'
    click_on 'テストナレッジ'
    click_on 'ティップ'
  end

  describe 'ティップ登録機能' do
    context 'ティップ登録操作をした場合' do
      it 'ティップ登録が完了し、ティップ一覧画面へ遷移される' do
        click_on 'ティップ登録'
        fill_in 'tip[name]', with: 'テストになります'
        fill_in 'tip[content]', with: 'テストでございます'
        check 'tip_tag_ids_1'
        attach_file 'tip[pictures_attributes][0][image]', "#{Rails.root}/spec/fixtures/test0.jpg"
        click_on '登録'
        expect(page).to have_content 'テストになります'
        expect(page).to have_content 'テストタグ'
        expect(page).to have_content 'ティップを登録しました。'
      end
    end
  end
  describe 'ティップ詳細機能' do
    context 'ティップ詳細操作をした場合' do
      it 'ティップの詳細画面へ遷移される' do
        click_on 'ティップ登録'
        fill_in 'tip[name]', with: 'テストになります'
        fill_in 'tip[content]', with: 'テストでございます'
        check 'tip_tag_ids_2'
        attach_file 'tip[pictures_attributes][0][image]', "#{Rails.root}/spec/fixtures/test0.jpg"
        click_on '登録'
        click_on 'テストになります'
        expect(page).to have_content 'テストになります'
        expect(page).to have_content 'テストでございます'
        expect(page).to have_content 'テストタグ'
        expect(page).to have_selector("img[src$='test0.jpg']")
      end
    end
  end
  describe 'ティップ編集機能' do
    context 'ティップ編集操作をした場合' do
      it 'ティップ編集ができる' do
        click_on 'テストティップ'
        click_on 'ティップ編集'
        fill_in 'tip[name]', with: 'ティップ編集機能テスト'
        fill_in 'tip[content]', with: '確認'
        attach_file 'tip[pictures_attributes][0][image]', "#{Rails.root}/spec/fixtures/test0.jpg"
        attach_file 'tip[pictures_attributes][1][image]', "#{Rails.root}/spec/fixtures/test1.jpg"
        click_on '登録'
        click_on 'ティップ編集機能テスト'
        expect(page).to have_content 'ティップ編集機能テスト'
        expect(page).to have_content '確認'
        expect(page).to have_selector("img[src$='test0.jpg']")
        expect(page).to have_selector("img[src$='test1.jpg']")
      end
    end
  end
  describe 'ティップ削除機能' do
    context 'ティップ削除操作をした場合' do
      it 'ティップ削除ができる' do
        click_on 'テストティップ'
        click_on 'ティップ編集'
        click_on '削除'
        page.accept_alert
        expect(page).not_to have_content 'テストティップ'
        expect(page).to have_content 'ティップを削除しました。'
      end
    end
  end
  describe 'ティップ検索機能' do
    context 'ティップの検索操作をした場合' do
      it '検索したティップが表示される' do
        fill_in 'q[name_cont]', with: 'fugaティップ'
        click_on '検索'
        expect(page).to have_content 'fugaティップ'
        expect(page).not_to have_content 'テストティップ'
      end
    end
  end
  describe 'ティップ(タグ)検索機能' do
    context 'ティップの(タグ)検索操作をした場合' do
      it '検索したティップが表示される' do
        fill_in 'q[tags_name_cont]', with: 'テストタグ'
        click_on '検索'
        expect(page).to have_content 'テストタグ'
        expect(page).to have_content 'fugaティップ'
        expect(page).not_to have_content 'fugaタグ'
        expect(page).not_to have_content 'テストティップ'
      end
    end
  end
end
