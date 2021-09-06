class Teams::MessagesController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @current_member = Member.find_by(team_id: @team.id, user_id: current_user.id)

    if GroupMember.where(member_id: @current_member.id, group_id: params[:message][:group_id]).present?
      @message = Message.create(params.require(:message).permit(:body, :group_id).merge(member_id: @current_member.id))

      @group = Group.find(params[:message][:group_id])
      @messages = @group.messages
      @group_members = @group.group_members

      @current_member_message_id = [] << @message.member.id
      @read_register = @group_members.pluck('member_id') - @current_member_message_id

      @read_register.each do |register|
        Read.create(member_id: register, message_id: @message.id)
      end

      redirect_to team_group_path(@team, @group)
    else
      redirect_to team_path(@team), notice: 'メッセージが作成できませんでした。'
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @group = Group.find(Message.find_by(id: params[:id]).group_id)
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to team_group_path(@team, @group), notice: 'メッセージを削除しました。'
  end
end
