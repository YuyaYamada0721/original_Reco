class Teams::Knowledges::StocksController < ApplicationController
  def create
    member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    Stock.create(member_id: member.id, knowledge_id: params[:knowledge_id])
    redirect_to team_knowledge_path(params[:team_id], params[:knowledge_id]), notice: 'ストックしました。'
  end

  def destroy
    member = Member.find_by(user_id: current_user.id, team_id: params[:team_id])
    Stock.find_by(member_id: member.id, knowledge_id: params[:knowledge_id]).destroy
    redirect_to team_knowledge_path(params[:team_id], params[:knowledge_id]), alert: 'ストックから外しました。'
  end
end
