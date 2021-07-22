class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :member_knowledge_check

  def index
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all
  end

  def new
    @knowledge = Knowledge.new
    @team = Team.find(params[:team_id])
  end

  def create
    @member = Member.where(team_id: params[:team_id]).find_by(user_id: current_user.id)
    @knowledge = Knowledge.new(member_id: @member.id, team_id: params[:team_id], name: params[:knowledge][:name])
    if @knowledge.save
      redirect_to team_knowledges_path, notice: 'ナレッジを登録しました。'
    else
      @team = Team.find(params[:team_id])
      render :new
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    @member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    @stock = @member.stocks.find_by(knowledge_id: @knowledge.id)
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    if @knowledge.update(knowledge_params)
      redirect_to team_knowledges_path, notice: '編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to team_knowledges_path, notice: '削除しました。'
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:member_id, :team_id, :name)
  end
end
