class Teams::TagsController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @tags = @team.tags.all
  end
end
