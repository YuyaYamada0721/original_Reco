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

  def current_user_check
    unless current_user == User.find(params[:id])
      flash[:notice] = '他のユーザページにはアクセスできません。'
      redirect_to user_path(current_user.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username image introduction admin])
  end

  def top; end
end
