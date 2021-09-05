class Teams::GroupsController < ApplicationController
  before_action :group_exist, only: :show

  def create
    @team = Team.find(params[:team_id])
    @current_member = @team.members.current_member_info(current_user)
    @group = Group.create(is_dm: true)
    @group_member1 = GroupMember.create(group_id: @group.id, member_id: @current_member.id)
    @group_member2 = GroupMember.create(params.require(:group_member).permit(:member_id, :group_id).merge(group_id: @group.id))
    redirect_to team_group_path(params[:team_id], @group.id)
  end

  def show
    @team = Team.find(params[:team_id])
    @current_member = @team.members.current_member_info(current_user)
    @group = Group.find(params[:id])
    @message = Message.new
    @messages = @group.messages.order(id: 'DESC')
    @group_members = @group.group_members.page(params[:page]).per(10)

    if Message.joins(:reads).find_by(reads: { is_checked: false, member_id: @current_member.id }, group_id: @group.id).present?

      @unread_messages = Message.joins(:reads).where(reads: { is_checked: false, member_id: @current_member.id }, group_id: @group.id)
      @unread_messages.each do |message|
        read = Read.find_by(member_id: @current_member.id, message_id: message.id)
        read.update(is_checked: true)
      end
    end
  end
end
