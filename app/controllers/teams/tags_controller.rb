class Teams::TagsController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @tags = @team.tags.all
  end

  def new
    @team = Team.find(params[:team_id])
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to team_tags_path, notice: 'タグを登録しました。'
    else
      render :new
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name).merge(team_id: params[:team_id].to_i)
  end
end
