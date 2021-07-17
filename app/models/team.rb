class Team < ApplicationRecord


  validates :name, presence: true, length: { in: 1..30 }, uniqueness: true

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :user

end
