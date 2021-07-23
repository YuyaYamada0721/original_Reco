class Member < ApplicationRecord
  validates :user_id, uniqueness: { scope: :team_id }

  belongs_to :user
  belongs_to :team

  has_many :knowledges, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocks_knowledges, through: :stocks, source: :knowledge

  before_create :solo_team?

  def solo_team?
    @team = Team.find(team_id)
    throw(:abort) if @team.is_solo == true && @team.members.count == 1
  end
end
