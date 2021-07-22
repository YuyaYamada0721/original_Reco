class Knowledge < ApplicationRecord
  validates :name, presence: true, length: { in: 1..30 }

  belongs_to :member
  belongs_to :team

  has_many :stocks, dependent: :destroy
end
