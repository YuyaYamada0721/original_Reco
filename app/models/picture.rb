class Picture < ApplicationRecord
  belongs_to :tip, optional: true

  mount_uploader :image, ImageUploader
end
