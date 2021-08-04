class Tagging < ApplicationRecord
  validates :tip_id, uniqueness: { scope: :tag_id }

  belongs_to :tip
  belongs_to :tag
end
