class Stock < ApplicationRecord
  validates :member_id, uniqueness: { scope: :knowledge_id }

  belongs_to :member
  belongs_to :knowledge
end
