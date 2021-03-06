class Group < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members, source: :member
end
