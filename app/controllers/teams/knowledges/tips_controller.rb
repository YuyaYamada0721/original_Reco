class Teams::Knowledges::TipsController < ApplicationController
  before_action :authenticate_user!
  before_action :team_member_check

  def index
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tips = @team.tips.all.page(params[:page]).per(6).order(id: 'DESC')
    @q = @tips.ransack(params[:q])
  end

  def new
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @tip = Tip.new
    @tip.pictures.build #画像の複数投稿は macならコマンド押しながら選択 windowsならctrl押しながら
  end

  def create
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tip = Tip.new(tip_params)
    @tip.member_id = @member.id

    if @tip.save

      if params[:pictures].present?
        params[:pictures][:image].each do |img|
          @tip_image = @tip.pictures.create(image: img, tip_id: @tip.id)
        end
      end

      redirect_to team_knowledge_tips_path, notice: 'Tipを作成しました。'
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:team_id])
    @tip = Tip.find(params[:id])

    @tip.pictures.build if @tip.pictures.blank? || @tip.pictures.count < 3 #写真が投稿されていないか写真の投稿が３つ以下の時に実施

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

  def search
    @team = Team.find(params[:team_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
    @member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    @tips = @team.tips.all.page(params[:page]).per(6).order(id: 'DESC')
    @q = @tips.ransack(params[:q])
    @results = @q.result
  end

  private

  def tip_params
    params.require(:tip).permit(:name, :content, tag_ids: [], pictures_attributes: %i[id tip_id image]).merge(knowledge_id: params[:knowledge_id],team_id: params[:team_id])
  end
end
