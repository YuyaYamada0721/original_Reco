require 'rails_helper'
RSpec.describe 'ナレッジモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ナレッジの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = Knowledge.new(name: '', member_id: member.id, team_id: team.id)
        expect(knowledge).not_to be_valid
      end
    end
    context 'ナレッジの名前が30字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = Knowledge.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDE', member_id: member.id, team_id: team.id)
        expect(knowledge).not_to be_valid
      end
    end
    context 'ナレッジの名前が30字の場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = Knowledge.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCD', member_id: member.id, team_id: team.id)
        expect(knowledge).to be_valid
      end
    end
    context 'ナレッジの名前が入力されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = Knowledge.new(name: 'テストナレッジ', member_id: member.id, team_id: team.id)
        expect(knowledge).to be_valid
      end
    end
  end
end
