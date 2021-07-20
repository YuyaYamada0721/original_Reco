class Teams::KnowledgesController < ApplicationController

  def index
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all
  end
end
