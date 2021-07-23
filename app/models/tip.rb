class Tip < ApplicationRecord
  belongs_to :member
  belongs_to :knowledge
  belongs_to :team
end
