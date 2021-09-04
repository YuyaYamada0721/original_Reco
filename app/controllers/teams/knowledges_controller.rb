class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :team_member_check, only: %i[index new create]
  before_action :team_knowledge_check, only: %i[show edit update destroy]
  before_action :knowledge_author_check, only: :edit
  before_action :set_team, except: :destroy
  before_action :set_knowledge, only: %i[show edit update destroy]

  def index
    @knowledges = @team.knowledges.paginate6_update_desc(params)
    @q = @knowledges.ransack(params[:q])
  end

  def new
    @knowledge = Knowledge.new
  end

  def create
    @current_member = @team.members.current_member_info(current_user)
    @knowledge = Knowledge.new(member_id: @current_member.id, team_id: @team.id, name: params[:knowledge][:name])
    if @knowledge.save
      redirect_to team_knowledges_path, notice: 'ナレッジを登録しました。'
    else
      render :new
    end
  end

  def show
    @current_member = @team.members.current_member_info(current_user)
    @stock = @current_member.stocks.find_by(knowledge_id: @knowledge.id)
  end

  def edit; end

  def update
    if @knowledge.update(knowledge_params)
      redirect_to team_knowledges_path, notice: 'ナレッジを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @knowledge.destroy
    redirect_to team_knowledges_path, notice: 'ナレッジを削除しました。'
  end

  def search
    @knowledges = @team.knowledges.paginate6_update_desc(params)
    @q = @knowledges.ransack(params[:q])
    @results = @q.result
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_knowledge
    @knowledge = Knowledge.find(params[:id])
  end

  def knowledge_params
    params.require(:knowledge).permit(:member_id, :team_id, :name, :q)
  end
end
