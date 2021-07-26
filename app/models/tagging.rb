class Tagging < ApplicationRecord
  validates :tip_id, presence: true
  validates :tag_id, presence: true

  belongs_to :tip
  belongs_to :tag
end
