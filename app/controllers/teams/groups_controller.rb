class Teams::GroupsController < ApplicationController

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
      @messages = @group.messages
      @message = Message.new
      @group_members = @group.group_members
    else
      redirect_to team_path(@team), notice: 'グループを作成して下さい。'
    end
  end
end
