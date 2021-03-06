class Teams::MembersController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @user = User.find_by(email: params[:team][:email])

    if @user.blank?
      redirect_to team_path(@team), notice: '存在しないユーザです。'
    elsif Member.find_by(user_id: @user.id, team_id: @team.id).present?
      redirect_to team_path(@team), notice: '既にメンバーの一員です。'
    else
      @member = Member.create(user_id: @user.id, team_id: @team.id)
      @owner = Member.find_by(team_id: @team.id, user_id: @team.owner.id)
      @team_message = Group.joins(:group_members).find_by(group_members: { member_id: @owner.id }, is_dm: 'false')
      GroupMember.create(member_id: @member.id, group_id: @team_message.id)
      redirect_to team_path(@team), notice: 'メンバーを追加しました。'
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @member = Member.find(params[:id])

    @dm_groups = Group.joins(:group_members).where(group_members: { member_id: @member.id }, is_dm: 'true')
    @dm_groups.each(&:destory)

    @member.destroy
    redirect_to team_path(@team), alert: 'メンバーを脱退させました。'
  end

  def show
    @team = Team.find(params[:team_id])
    @member = Member.find(params[:id])
    @member_group_member = GroupMember.where(member_id: @member.id) #対象のメンバーのグループ情報
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id) #現在のユーザのメンバーとしての情報
    @current_member_group_member = GroupMember.where(member_id: @current_member.id) #現在のユーザのメンバーとしてのグループ情報
    @stocks = Stock.where(member_id: params[:id]).page(params[:page]).per(5) #メンバーでの画面でストック一覧を表示させるため

    unless @member.id == @current_member.id
      @current_member_group_member.each do |cmgm|
        @member_group_member.each do |mgm|
          if cmgm.group_id == mgm.group_id && cmgm.group.is_dm == true
            @is_group = true
            @group_id = cmgm.group_id
          end
        end
      end
      unless @is_group
        @group = Group.new
        @group_member = GroupMember.new
      end
    end
  end
end
