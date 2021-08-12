class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :team_member_check, only: %i[index new create]
  before_action :team_knowledge_check, only: %i[show edit update destroy]

  def index
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all.page(params[:page]).per(6).order(id: 'DESC')
    @q = @knowledges.ransack(params[:q])
  end

  def new
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.new
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
    @member = Member.find_by(team_id: @team.id, user_id: current_user.id)
    @stock = @member.stocks.find_by(knowledge_id: @knowledge.id)
  end

  def edit
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:id])
    if @knowledge.update(knowledge_params)
      redirect_to team_knowledges_path, notice: 'ナレッジを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to team_knowledges_path, notice: 'ナレッジを削除しました。'
  end

  def search
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all.page(params[:page]).per(6).order(id: 'DESC')
    @q = @knowledges.ransack(params[:q])
    @results = @q.result
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:member_id, :team_id, :name, :q)
  end
end
