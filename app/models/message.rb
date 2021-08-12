class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :member
  belongs_to :group

  has_many :reads, dependent: :destroy
end
