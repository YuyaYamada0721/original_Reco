class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :team_members_check, only: %i[show]
  before_action :set_team, only: %i[destroy edit update show owner_change invitation]

  def index
    @teams = current_user.members_teams
    @q = @teams.ransack(params[:q])
    @teams = @q.result(distinct: true)
  end

  def show
    @members = Member.where(team_id: params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.owner_id = current_user.id
    if @team.save
      @team.invite_member(@team.user)
    else
      redirect_to teams_path, notice: '作成できませんでした'
    end
  end

  def destroy
    @team.destroy
  end

  def edit; end

  def update
    @team.update(team_params)
  end

  def secession
    @user = User.find_by(id: params[:user_id])
    @member = Member.find_by(user_id: @user.id, team_id: params[:id])
    @member.destroy
    redirect_to team_path, notice: 'メンバーを脱退させました。'
  end

  def owner_change
    @team.update(owner_id: params[:owner_id])
    redirect_to team_path, notice: 'チームオーナーを交代しました。'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo, :q)
  end
end
