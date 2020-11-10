class Picture < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :user, optional: true

  # mount_uploader :image, ImageUploader
end
