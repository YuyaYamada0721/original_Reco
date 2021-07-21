class Teams::MembersController < ApplicationController

  def create
    team = Team.find(params[:team_id])
    user = User.find_by(email: params[:team][:email])
    if user.blank?
      redirect_to team_path(team), notice: '存在しないユーザです。'
    elsif Member.find_by(user_id: user.id, team_id: team.id).present?
      redirect_to team_path(team), notice: '既にメンバーの一員です。'
    else
      Member.create(user_id: user.id, team_id: team.id)
      redirect_to team_path(team), notice: 'メンバーを追加しました。'
    end
  end

  def destroy
    team = Team.find_by(id: params[:team_id])
    member = Member.find_by(team_id: team.id, user_id: params[:id])
    member.destroy
    redirect_to team_path(params[:team_id])
  end
end
