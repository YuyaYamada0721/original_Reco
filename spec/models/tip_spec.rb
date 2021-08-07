require 'rails_helper'
RSpec.describe 'ティップモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ティップの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = FactoryBot.create(:knowledge, member_id: member.id, team_id: team.id)
        tip = Tip.new(name: '', knowledge_id: knowledge.id, member_id: member.id, team_id: team.id)
        expect(tip).not_to be_valid
      end
    end
    context 'ティップの名前が30字を超える場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = FactoryBot.create(:knowledge, member_id: member.id, team_id: team.id)
        tip = Tip.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDE', knowledge_id: knowledge.id, member_id: member.id, team_id: team.id)
        expect(tip).not_to be_valid
      end
    end
    context 'ティップの名前が30字の場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = FactoryBot.create(:knowledge, member_id: member.id, team_id: team.id)
        tip = Tip.new(name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCD', knowledge_id: knowledge.id, member_id: member.id, team_id: team.id)
        expect(tip).to be_valid
      end
    end
    context 'ティップの名前が入力されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        knowledge = FactoryBot.create(:knowledge, member_id: member.id, team_id: team.id)
        tip = Tip.new(name: 'テストティップ', knowledge_id: knowledge.id, member_id: member.id, team_id: team.id)
        expect(tip).to be_valid
      end
    end
  end
end
