class Picture < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :user, optional: true

  # mount_uploader :image, ImageUploader
  def self.search(search)
    return Picture.where(publish: true) unless search
    Picture.where(['title LIKE ?', "%#{search}%"]).where(publish: true)
  end
end
