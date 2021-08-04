class Picture < ApplicationRecord
  belongs_to :tip

  mount_uploader :image, ImageUploader
end
