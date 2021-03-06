class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    user_path(current_user.id)
  end

  def user_check #  users
    return if User.find_by_id(params[:id]) == current_user

    flash[:alert] = '警告：禁止行為'
    redirect_to user_path(current_user)
  end

  def team_members_check # teams
    return if Member.where(team_id: params[:id]).where(user_id: current_user.id).present?

    flash[:notice] = 'メンバーではないチーム情報は見れません。'
    redirect_to teams_path
  end

  def team_owner_check # teams
    return if current_user == Team.find(params[:id]).owner

    flash[:notice] = 'チームのオーナーしかアクセスできません。'
    redirect_to teams_path
  end

  def team_knowledge_check # knowledges
    @knowledge = Knowledge.find(params[:id])
    return if Member.where(team_id: @knowledge.team_id, user_id: current_user.id).present?

    flash[:notice] = 'メンバーでないのでアクセスできません。'
    redirect_to teams_path
  end

  def knowledge_author_check # knowledges
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    return if @current_member.id == @knowledge.member_id

    flash[:notice] = 'ナレッジの作成者でないとアクセスできません。'
    redirect_to team_knowledges_path
  end

  def team_function_owner_only #tags
    @team = Team.find(params[:team_id])
    return if @team.owner.id == current_user.id

    flash[:notice] = 'チームのオーナーでないとアクセスできません。'
    redirect_to team_tags_path
  end

  def team_member_check # tags knowledges
    unless Member.where(team_id: params[:team_id]).find_by(user_id: current_user.id).present?
      flash[:notice] = 'メンバーでないのでアクセスできません。'
      redirect_to teams_path
    end
  end

  def tip_author_check
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    @tip = Tip.find(params[:id])
    return if @current_member.id == @tip.member_id

    flash[:notice] = 'ティップの作成者でないとアクセスできません。'
    redirect_to team_knowledges_path
  end

  def group_exist # group_idをURLに直接パラメータ入力でアクセスしようとする制限 groups
    redirect_to teams_path, notice: 'アクセスできません' if Group.last.id < params[:id].to_i
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username image introduction admin])
  end
end
