class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :team_member_check

  def index
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all.page(params[:page]).per(6)
  end

  def new
    @knowledge = Knowledge.new
    @team = Team.find(params[:team_id])
  end

  def create
    @team = Team.find(params[:team_id])
    @member = Member.where(team_id: @team.id).find_by(user_id: current_user.id)
    @knowledge = Knowledge.new(member_id: @member.id, team_id: @team.id, name: params[:knowledge][:name])
    if @knowledge.save
      redirect_to team_knowledges_path, notice: 'ナレッジを登録しました。'
    else
      render :new
    end
  end

  def show
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:id])
    @member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    @stock = @member.stocks.find_by(knowledge_id: @knowledge.id)
  end

  def edit
    @team = Team.find(params[:id])
    @knowledge = Knowledge.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
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
