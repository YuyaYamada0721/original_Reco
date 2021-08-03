class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    user_path(current_user.id)
  end

  def team_members_check
    unless Member.where(team_id: params[:id]).where(user_id: current_user.id).present?
      flash[:notice] = 'メンバーではないチーム情報は見れません。'
      redirect_to teams_path
    end
  end

  def team_member_check
    unless Member.where(team_id: params[:team_id]).find_by(user_id: current_user.id).present?
      flash[:notice] = 'メンバーでないのでアクセスできません。'
      redirect_to teams_path
    end
  end

  def team_owner_check 
    return if current_user == Team.find(params[:id]).owner

    flash[:notice] = 'チームのオーナーしかアクセスできません。'
    redirect_to teams_path
  end

  def tag_check #tips登録時、tag_idsのパラメータがなければtaggingからデータを削除する
    if params[:tip][:tag_ids] == nil
      @tags = Tagging.where(tip_id: @tip.id)
      @tags.each do |tag|
        tag.destroy
      end
    end
  end

  def group_exist #URLに直接パラメータ入力でアクセス制限
    redirect_to teams_path, notice: 'アクセスできません。' if Group.last.id < params[:id].to_i
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username image introduction admin])
  end
end
