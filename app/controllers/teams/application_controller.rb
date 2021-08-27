class Teams::ApplicationController < ApplicationController
  before_action :set_team

  def set_team # 同じチームでないUserページにアクセスさせない users
    @team = current_user.teams.find(params[:team_id])

    # if User.find_by(id: params[:id]).nil?
    #   redirect_to user_path(current_user), notice: 'ユーザは存在しません。'
    # elsif current_user.id != params[:id].to_i
    #   current_user_join_team = current_user.members.pluck('team_id')
    #   subject_user = User.find(params[:id]).members.pluck('team_id')
    #   same_team_judgment = current_user_join_team + subject_user
    #   result = same_team_judgment.select { |judgment| same_team_judgment.count(judgment) > 1 }.uniq
    #   unless result.present?
    #     redirect_to user_path(current_user), notice: 'チームメンバーではないのでアクセスできません。'
    #   end
    # end
  end
