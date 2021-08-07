require 'rails_helper'
RSpec.describe 'タグモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タグの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        tag = Tag.new(name: '', team_id: team.id)
        expect(tag).not_to be_valid
      end
    end
    context 'タグの名前が30字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        tag = Tag.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDE', team_id: team.id)
        expect(tag).not_to be_valid
      end
    end
    context 'ナレッジの名前が30字の場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        tag = Tag.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCD', team_id: team.id)
        expect(tag).to be_valid
      end
    end
    context 'ナレッジの名前が入力されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        tag = Tag.new(name: 'テストタグ', team_id: team.id)
        expect(tag).to be_valid
      end
    end
  end
end
