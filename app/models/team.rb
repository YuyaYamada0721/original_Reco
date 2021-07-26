class Team < ApplicationRecord
  validates :name, presence: true, length: { in: 1..30 }

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :user

  has_many :members, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_many :tags, dependent: :destroy

  def invite_member(user)
    members.create(user: user)
  end
end
