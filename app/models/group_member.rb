class GroupMember < ApplicationRecord
  validates :member_id, uniqueness: { scope: :group_id }

  belongs_to :member
  belongs_to :group
end
