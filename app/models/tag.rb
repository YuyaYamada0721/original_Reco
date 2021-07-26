class Tag < ApplicationRecord
  belongs_to :team

  has_many :taggings, dependent: :destroy
  has_many :tips, through: :taggings
end
