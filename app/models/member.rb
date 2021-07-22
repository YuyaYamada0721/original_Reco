class Member < ApplicationRecord
  validates :user_id, uniqueness: { scope: :team_id }

  belongs_to :user
  belongs_to :team

  has_many :knowledges, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocks_knowledges, through: :stocks, source: :knowledge
end
