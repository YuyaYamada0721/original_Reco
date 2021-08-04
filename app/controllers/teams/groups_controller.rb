class Teams::GroupsController < ApplicationController
  before_action :group_exist, only: :show

  def create
    @team = Team.find(params[:team_id])
    @current_member = Member.find_by(team_id: @team.id, user_id: current_user.id)
    @group = Group.create(is_dm: true)
    @group_member1 = GroupMember.create(group_id: @group.id, member_id: @current_member.id)
    @group_member2 = GroupMember.create(params.require(:group_member).permit(:member_id, :group_id).merge(group_id: @group.id))
    redirect_to team_group_path(params[:team_id], @group.id)
  end

  def show
    @team = Team.find(params[:team_id])
    @current_member = Member.find_by(team_id: @team.id, user_id: current_user.id)
    @group = Group.find(params[:id])

    if GroupMember.where(member_id: @current_member.id, group_id: @group.id).present?
      @messages = @group.messages.order(id: 'DESC')
      @message = Message.new
      @group_members = @group.group_members.page(params[:page]).per(10)

      @read_check = Read.where(member_id: @current_member.id).pluck('message_id') #Readテーブルで自分が確認したmessage情報を取得
      @group_message_check = @messages.pluck('id') #groupのmessage情報を取得
      @reads = @group_message_check - @read_check #group showをした時点でReadテーブルに保存したいmessage情報に絞る
      @reads.each do |read| #Readテーブルへ未確認messageを見た is_checkedをtrue として保存
        Read.create(member_id: @current_member.id, message_id: read, is_checked: true)
      end
    else
      redirect_to team_path(@team), notice: 'アクセスできません'
    end
  end
end
