class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    user_path(current_user.id)
  end

  def same_team_check # 同じチームでないUserページにアクセスさせない users
    if User.find_by(id: params[:id]).nil?
      redirect_to user_path(current_user), notice: 'ユーザは存在しません。'
    elsif current_user.id != params[:id].to_i
      current_user_join_team = current_user.members.pluck('team_id')
      subject_user = User.find(params[:id]).members.pluck('team_id')
      same_team_judgment = current_user_join_team + subject_user
      result = same_team_judgment.select { |judgment| same_team_judgment.count(judgment) > 1 }.uniq
      unless result.present?
        redirect_to user_path(current_user), notice: 'チームメンバーではないのでアクセスできません。'
      end
    end
  end

  def team_members_check # teams
    unless Member.where(team_id: params[:id]).where(user_id: current_user.id).present?
      flash[:notice] = 'メンバーではないチーム情報は見れません。'
      redirect_to teams_path
    end
  end

  def team_owner_check # teams
    return if current_user == Team.find(params[:id]).owner

    flash[:notice] = 'チームのオーナーしかアクセスできません。'
    redirect_to teams_path
  end

  def team_knowledge_check # knowledges
    @knowledge = Knowledge.find(params[:id])
    unless Member.where(team_id: @knowledge.team_id, user_id: current_user.id).present?
      flash[:notice] = 'メンバーでないのでアクセスできません。'
      redirect_to teams_path
    end
  end

  def knowledge_author_check # knowledges
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    unless @current_member.id == @knowledge.member_id
      flash[:notice] = 'ナレッジの作成者でないとアクセスできません。'
      redirect_to team_knowledges_path
    end
  end

  def team_member_check # tags knowledges
    unless Member.where(team_id: params[:team_id]).find_by(user_id: current_user.id).present?
      flash[:notice] = 'メンバーでないのでアクセスできません。'
      redirect_to teams_path
    end
  end

  def tag_check # tips登録時、tag_idsのパラメータがなければtaggingからデータを削除する tips
    if params[:tip][:tag_ids] == nil
      @tags = Tagging.where(tip_id: @tip.id)
      @tags.each do |tag|
        tag.destroy
      end
    end
  end

  def group_exist # group_idをURLに直接パラメータ入力でアクセスしようとする制限 groups
    redirect_to teams_path, notice: 'アクセスできません' if Group.last.id < params[:id].to_i
  end

  def already_exist_team # 同じ名前のチームを作成できない teams
    @team = current_user.teams.build(team_params)
    if Team.where(user_id: current_user.id, name: params[:team][:name]).present?
      flash[:notice] = '既に存在するチーム名です。'
      render :new
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username image introduction admin])
  end
end
