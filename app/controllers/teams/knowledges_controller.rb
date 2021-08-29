class Teams::KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :team_member_check, only: %i[index new create]
  before_action :team_knowledge_check, only: %i[show edit update destroy]
  before_action :knowledge_author_check, only: :edit
  before_action :set_team, except: :destroy
  before_action :set_knowledge, only: %i[show edit update destroy]


  def index
    @knowledges = @team.knowledges.all.page(params[:page]).per(6).order(id: 'DESC')
    @q = @knowledges.ransack(params[:q])
  end

  def new
    @knowledge = Knowledge.new
  end

  def create
    @member = Member.where(team_id: @team.id).find_by(user_id: current_user.id)
    @knowledge = Knowledge.new(member_id: @member.id, team_id: @team.id, name: params[:knowledge][:name])
    if @knowledge.save
      redirect_to team_knowledges_path, notice: 'ナレッジを登録しました。'
    else
      render :new
    end
  end

  def show
    @current_member = Member.find_by(team_id: @team.id, user_id: current_user.id)
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
    @knowledges = @team.knowledges.all.page(params[:page]).per(6).order(id: 'DESC')
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
