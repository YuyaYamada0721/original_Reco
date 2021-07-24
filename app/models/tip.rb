class Tip < ApplicationRecord
  validates :name, presence: true

  belongs_to :member
  belongs_to :knowledge
  belongs_to :team

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures
end
