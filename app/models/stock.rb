class Stock < ApplicationRecord
  belongs_to :member
  belongs_to :knowledge
end
