class Teams::Knowledges::TipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tips = @team.tips.all
  end

  def new
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @tip = Tip.new
    3.times { @tip.pictures.build }
  end

  def create
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tip = Tip.new(tip_params)
    @tip.member_id = @member.id
    if @tip.save
      redirect_to team_knowledge_tips_path, notice: 'Tipを作成しました。'
    else
      render :new
    end
  end

  def edit
    @tip = Tip.find(params[:id])
    @tip.pictures.build
  end

  def update
    @tip = Tip.find(params[:id])
    if @tip.update(tip_params)
      redirect_to team_knowledge_tips_path, notice: '編集しました。'
    else
      render :edit
    end
  end

  def show
    @tip = Tip.find(params[:id])
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy
    redirect_to team_knowledge_tips_path, notice: '削除しました。'
  end

  private

  def tip_params
    params.require(:tip).permit(:name, :content, tag_ids: [], pictures_attributes: %i[id tip_id image image_cache _destroy]).merge(knowledge_id: params[:knowledge_id],team_id: params[:team_id])
  end
end
