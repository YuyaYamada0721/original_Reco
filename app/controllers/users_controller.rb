class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.upadate(user_params)
      redirect_to user_path, notice: '編集しました。'
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :image, :introduction, :admin)
  end
end
