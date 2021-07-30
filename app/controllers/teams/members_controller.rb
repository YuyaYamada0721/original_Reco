class Teams::MembersController < ApplicationController

  def create
    @team = Team.find(params[:team_id])
    @user = User.find_by(email: params[:team][:email])
    if user.blank?
      redirect_to team_path(@team), notice: '存在しないユーザです。'
    elsif Member.find_by(user_id: @user.id, team_id: @team.id).present?
      redirect_to team_path(@team), notice: '既にメンバーの一員です。'
    else
      @member = Member.create(user_id: @user.id, team_id: @team.id)
      @owner = Member.find_by(team_id: @team.id, user_id: @team.owner.id)
      @team_chat = Group.joins(:group_members).find_by(group_members: { member_id: @owner.id }, is_dm: 'false')
      GroupMember.create(member_id: @member.id, group_id: @team_chat.id)
      redirect_to team_path(@team), notice: 'メンバーを追加しました。'
    end
  end

  def destroy
    team = Team.find_by(id: params[:team_id]).id
    user = Member.find(params[:id]).user.id
    member = Member.find_by(team_id: team, user_id: user)
    member.destroy
    redirect_to team_path(team), notice: 'メンバーを脱退させました。'
  end

  def show
    @team = Team.find(params[:team_id])
    @stocks = Stock.where(member_id: params[:id])
    @member = Member.find(params[:id])
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    @current_member_group_member = GroupMember.where(member_id: @current_member.id)
    @member_group_member = GroupMember.where(member_id: @member.id)

    @owner = Member.find_by(team_id: @team.id, user_id: @team.owner.id)
    @check_test = Group.joins(:group_members).find_by(group_members: { member_id: @current_member.id }, is_dm: 'true')

    if @member.id == @current_member.id
    else
      @current_member_group_member.each do |cu|
        @member_group_member.each do |u|
          if cu.group_id == u.group_id && @check_test.present? && cu.group.is_dm == true 
            @is_group = true
            @group_id = cu.group_id
          end
        end
      end
      if @is_group
      else
        @group = Group.new
        @group_member = GroupMember.new
      end
    end
  end
end
