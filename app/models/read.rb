class Read < ApplicationRecord
  validates :member_id, uniqueness: { scope: :message_id }

  belongs_to :member
  belongs_to :message
end
