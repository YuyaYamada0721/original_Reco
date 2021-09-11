class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :team_owner_check, only: :edit
  before_action :team_members_check, only: :show
  before_action :set_team, except: %i[index new create search]

  def index
    @teams = current_user.members_teams.page(params[:page]).per(6)
    @q = @teams.ransack(params[:q])
    @teams = @q.result(distinct: true)
  end

  def show
    @members = @team.members.page(params[:page]).per(5)
    @random = @members.random_one(@members)

    # チームメッセージへ遷移するための準備
    @owner = Member.find_by(team_id: @team.id, user_id: @team.owner.id)
    @team_message = Group.joins(:group_members).find_by(group_members: { member_id: @owner.id }, is_dm: 'false')
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.name = @team.name.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')

    if Team.find_by(user_id: current_user.id, name: @team.name).present?
      flash[:notice] = '保存できませんでした。既に存在するチーム名です。'
      render :new
    elsif @team.save
      @team.invite_member(@team.user)
      @owner_at_the_member_table = Member.find_by(team_id: @team.id, user_id: current_user.id)
      @group = Group.create
      @group_member_ = GroupMember.create(group_id: @group.id, member_id: @owner_at_the_member_table.id)
      redirect_to teams_path, notice: 'チームを登録しました。'
    else
      render :new
    end
  end

  def edit
    @members = @team.members.page(params[:page]).per(5)
  end

  def update
    # 更新時にエラー発生した場合render先で必要
    @members = @team.members.page(params[:page]).per(5)
    if @team.update(team_params)
      redirect_to teams_path, notice: 'チームを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @members = @team.members

    #チームを削除する時にこのチームで作成したGroupも削除する処理
    @members.each do |member|
      @dm_groups = Group.joins(:group_members).where(group_members: { member_id: member.id })
      @dm_groups.each(&:destroy)
    end
    @team.destroy
    redirect_to teams_path, alert: 'チームを削除しました。'
  end

  def owner_change
    @team.update(owner_id: params[:owner_id])
    redirect_to team_path, notice: 'チームオーナーを交代しました。'
  end

  def search
    @teams = current_user.members_teams.page(params[:page]).per(6)
    @q = @teams.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:user_id, :owner_id, :name, :is_solo, :q)
  end
end
