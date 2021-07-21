class Teams::MembersController < ApplicationController

  def create
    if User.find_by(email: params[:team][:email])
      @user = User.find_by(email: params[:team][:email])
      Member.create(user_id: @user.id, team_id: params[:team_id])
      redirect_to team_path(params[:team_id]), notice: 'メンバーを追加しました。'
    else
      redirect_to team_path, notice: '招待できませんでした。'
    end
  end

  def destroy
    team = Team.find_by(id: params[:team_id])
    member = Member.find_by(team_id: team.id, user_id: params[:id])
    member.destroy
    redirect_to team_path(params[:team_id])
  end
end
