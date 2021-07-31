class Teams::MessagesController < ApplicationController

  def create
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)
    if GroupMember.where(member_id: @current_member.id, group_id: params[:message][:group_id]).present?
      @message = Message.create(params.require(:message).permit(:member_id, :body, :group_id).merge(member_id: @current_member.id))
      redirect_to team_group_path(params[:team_id], @message.group_id)
    else
      redirect_to team_path(params[:team_id]), notice: 'メッセージが作成できませんでした。'
    end
  end

end
