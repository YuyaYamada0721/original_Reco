class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[destroy edit update show]

  def index
    @teams = current_user.teams.all
  end

  def show
    @member = current_user.members.find_by(team_id: @team.id)
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

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo)
  end
end
