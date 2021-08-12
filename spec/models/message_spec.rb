require 'rails_helper'
RSpec.describe 'メッセージモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'メッセージの内容が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        group = FactoryBot.create(:group)
        message = Message.new(body: '', member_id: member.id, group_id: group.id)
        expect(message).not_to be_valid
      end
    end
    context 'メッセージの内容が入力されているの場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        team = FactoryBot.create(:team, user_id: user.id, owner_id: user.id)
        member = FactoryBot.create(:member, user_id: user.id, team_id: team.id)
        group = FactoryBot.create(:group)
        message = Message.new(body: 'テストです', member_id: member.id, group_id: group.id)
        expect(message).to be_valid
      end
    end
  end
end
