class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:delete_image]
      @user.image = nil
      @user.save
      render :edit
      nil
    elsif @user.update(user_params)
      redirect_to user_path, notice: '編集しました。'
      bypass_sign_in(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :image, :image_cache, :delete_image,
                                 :introduction, :admin)
  end
end
