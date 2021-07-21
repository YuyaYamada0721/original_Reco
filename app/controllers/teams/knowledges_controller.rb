class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :member_knowledge_check
  before_action :set_knowledge, only: %i[show edit update destroy]

  def index
    @team = Team.find(params[:team_id])
    @knowledges = @team.knowledges.all
  end

  def new
    @knowledge = Knowledge.new
  end

  def create
    @member = Member.where(team_id: params[:team_id]).find_by(user_id: current_user.id)
    @knowledge = Knowledge.new(member_id: @member.id, team_id: params[:team_id], name: params[:team][:name])
    if @knowledge.save
      redirect_to team_knowledges_path, notice: 'ナレッジを登録しました。'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @knowledge.update(knowledge_params)
      redirect_to team_knowledges_path, notice: '編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @knowledge.destroy
    redirect_to team_knowledges_path, notice: '削除しました。'
  end

  private

  def set_knowledge
    @knowledge = Knowledge.find(params[:id])
  end

  def knowledge_params
    params.require(:knowledge).permit(:member_id, :team_id, :name)
  end
end
