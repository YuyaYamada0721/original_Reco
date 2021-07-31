class Teams::TagsController < ApplicationController
  before_action :team_member_check

  def index
    @team = Team.find(params[:team_id])
    @tags = @team.tags.all.page(params[:page]).per(7)
  end

  def new
    @team = Team.find(params[:team_id])
    @tag = Tag.new
  end

  def create
    @team = Team.find(params[:team_id])
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to team_tags_path, notice: 'タグを登録しました。'
    else
      render :new
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to team_tags_path, notice: 'タグを削除しました。'
  end

  private

  def tag_params
    params.require(:tag).permit(:name).merge(team_id: params[:team_id].to_i)
  end
end
