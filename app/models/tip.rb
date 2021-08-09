class Tip < ApplicationRecord
  validates :name, presence: true, length: { in: 1..30 }

  belongs_to :member
  belongs_to :knowledge
  belongs_to :team

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :pictures, dependent: :destroy
  
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
