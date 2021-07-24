class Tip < ApplicationRecord
  validates :name, presence: true

  belongs_to :member
  belongs_to :knowledge
  belongs_to :team
end
