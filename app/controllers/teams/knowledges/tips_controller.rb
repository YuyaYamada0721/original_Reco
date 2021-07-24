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
  end

  def create
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tip = Tip.new(member_id: @member.id, knowledge_id: @knowledge.id, team_id: @team.id, name: params[:tip][:name], content: params[:tip][:content])
    if @tip.save
      redirect_to team_knowledge_tips_path, notice: 'Tipを作成しました。'
    else
      render :new
    end
  end

  private

  def tip_params
    params.require(:tip).permit(:member_id, :knowledge_id, :team_id, :name, :content)
  end

end
