class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_check, only: %i[show]
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: '編集しました。'
      bypass_sign_in(@user) #Userを編集してもログイン状態を維持
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :image, :image_cache, :introduction, :admin)
  end
end
