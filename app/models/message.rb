class Message < ApplicationRecord
  belongs_to :member
  belongs_to :group

  has_many :reads, dependent: :destroy
end
