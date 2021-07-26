class Teams::TagsController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @tags = @team.tags.all
  end

  def new
    @team = Team.find(params[:team_id])
    @tag = Tag.new
  end

  private

  def tag_params
    params.require(:tag).permit(:team_id, :name)
  end
end
