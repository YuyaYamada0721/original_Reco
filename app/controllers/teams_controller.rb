class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :team_members_check, except: :index

  def index
    @teams = current_user.members_teams
    @q = @teams.ransack(params[:q])
    @teams = @q.result(distinct: true)
  end

  def show
    @team = Team.find(params[:id])
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
    @team = Team.find(params[:id])
    @team.destroy
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)
  end

  def owner_change
    @team = Team.find(params[:id])
    @team.update(owner_id: params[:owner_id])
    redirect_to team_path, notice: 'チームオーナーを交代しました。'
  end

  private

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo, :q)
  end
end
