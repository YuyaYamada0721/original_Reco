class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :team_owner_check, only: :edit
  before_action :team_members_check, only: :show

  def index
    @teams = current_user.members_teams
    @q = @teams.ransack(params[:q])
    @teams = @q.result(distinct: true).page(params[:page]).per(6)
  end

  def show
    @team = Team.find(params[:id])
    @members = Member.where(team_id: params[:id]).page(params[:page]).per(5)
    @member = Member.find_by(team_id: params[:id], user_id: current_user.id)
    @stocks = Stock.where(member_id: @member.id)
    @owner = Member.find_by(team_id: params[:id], user_id: @team.owner.id)
    
    @team_chat = Group.joins(:group_members).find_by(group_members: { member_id: @owner.id }, is_dm: 'false')
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.owner_id = current_user.id
    if @team.save
      @team.invite_member(@team.user)
      @owner_at_the_member_table = Member.find_by(team_id: @team.id, user_id: current_user.id)
      @group = Group.create
      @group_member_ = GroupMember.create(group_id: @group.id, member_id: @owner_at_the_member_table.id)
      redirect_to teams_path, notice: 'チームを登録しました。'
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
    @members = Member.where(team_id: params[:id]).page(params[:page]).per(5)
  end

  def update
    @team = Team.find(params[:id])
    @members = Member.where(team_id: params[:id])
    if @team.update(team_params)
      redirect_to teams_path, notice: 'チームを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path, notice: 'チームを削除しました。'
  end

  def owner_change
    @team = Team.find(params[:id])
    @team.update(owner_id: params[:owner_id])
    redirect_to team_path, notice: 'チームオーナーを交代しました。'
  end

  def search
    @teams = current_user.members_teams.page(params[:page]).per(6)
    @q = @teams.ransack(params[:q])
    @teams = @q.result(distinct: true)
    @q = @teams
    @results = @q.result
  end

  private

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo, :q)
  end
end
