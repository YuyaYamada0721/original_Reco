class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_check
  before_action :set_user

  def show; end

  def edit; end

  def update
    if params[:delete_image]
      @user.image = nil
      @user.save
      render :edit
    elsif @user.update(user_params)
      redirect_to user_path, notice: '編集しました。'
      bypass_sign_in(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :image, :image_cache, :delete_image,
                                 :introduction, :admin)
  end
end
