class TeamsController < ApplicationController
  def index
    @teams = current_user.teams.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.owner_id = current_user.id
    if @team.save
      @team.invite_member(@team.user)
      redirect_to teams_path
    end
  end

  private

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo)
  end
end
