class Tag < ApplicationRecord
  validates :name, presence: true, length: { in: 1..30 }

  belongs_to :team

  has_many :taggings, dependent: :destroy
  has_many :tips, through: :taggings
end
