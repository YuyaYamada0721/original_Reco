class Group < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members, source: :member

  def create_each_other(user, other)
    Group.transaction do
      group_members.create(member: user)
      group_members.create(member: other)
    end
  end
end

