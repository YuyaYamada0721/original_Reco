class Teams::MessagesController < ApplicationController
  def create
    @current_member = Member.find_by(team_id: params[:team_id], user_id: current_user.id)

    if GroupMember.where(member_id: @current_member.id, group_id: params[:message][:group_id]).present?
      @message = Message.create(params.require(:message).permit(:member_id, :body, :group_id).merge(member_id: @current_member.id))

      # グループ情報
      @group = Group.find(params[:message][:group_id])
      # グループメッセージ全部
      @messages = @group.messages
      # グループメンバー全員
      @group_members = @group.group_members
      # 操作中ユーザーのメンバーidでのメッセージ全部
      @current_member_message = @current_member.messages

      # Readテーブルに自分以外のメンバーidで未読メッセージとして保存したい
      # @group_members情報は配列で格納されている為、自分の情報を削除できるように配列に格納する
      @current_member_message_id = [] << @message.member.id

      # グループメンバーのメンバーid群から自分のメンバーidを削除する
      @read_register = @group_members.pluck('member_id') - @current_member_message_id

      # Readテーブルから@read_registerに格納されているメンバーidにヒットするメッセージのidを取得する
      # whereのカラム値が配列でも検索できた
      # @read_check = Read.where(member_id: @read_register).pluck('message_id')
      # @group_message_check = @messages.pluck('id') # 現在のグループのメッセージ全部のidを取得
      # @reads = @group_message_check - @read_check
      # 現在のグループのメッセージ全部から、現時点でのReadテーブルに格納されている自分以外のメッセージidに絞る

        # @reads.each do |read|
          @read_register.each do |register|
            Read.create(member_id: register, message_id: @message.id)
          end
        # end
      # 繰り返し処理にて、まだ格納されていないメッセージに対して、自分以外のメンバーidで未読としてReadテーブルに登録する

      redirect_to team_group_path(params[:team_id], @message.group_id)
    else
      redirect_to team_path(params[:team_id]), notice: 'メッセージが作成できませんでした。'
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
