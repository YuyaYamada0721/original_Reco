class Tagging < ApplicationRecord
  belongs_to :tip
  belongs_to :tag
end
