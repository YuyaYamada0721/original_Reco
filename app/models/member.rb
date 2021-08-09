class Member < ApplicationRecord
  validates :user_id, uniqueness: { scope: :team_id }

  belongs_to :user
  belongs_to :team

  has_many :knowledges, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocks_knowledges, through: :stocks, source: :knowledge
  has_many :tips, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reads, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members, source: :group

  before_create :solo_team?

  def solo_team?
    @team = Team.find(team_id)
    throw(:abort) if @team.is_solo == true && @team.members.count == 1
  end
end
