require 'rails_helper'
RSpec.describe 'チームモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'チームの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = Team.new(name: '', user_id: user.id, owner_id: user.id)
        expect(team).not_to be_valid
      end
    end
    context 'チームの名前が30字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = Team.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDE', user_id: user.id, owner_id: user.id)
        expect(team).not_to be_valid
      end
    end
    context 'チームの名前が30字の場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = Team.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCD', user_id: user.id, owner_id: user.id)
        expect(team).to be_valid
      end
    end
    context 'チームの名前が入力されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = Team.new(name: 'テストチーム', user_id: user.id, owner_id: user.id)
        expect(team).to be_valid
      end
    end
  end
end
