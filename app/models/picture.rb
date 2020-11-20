class Picture < ApplicationRecord
  belongs_to :album, optional: true
  belongs_to :user, optional: true
  has_many :favopics

  # mount_uploader :image, ImageUploader
  def self.search(search)
    return Picture.where(publish: true) unless search
    Picture.where(['title LIKE ?', "%#{search}%"]).where(publish: true)
  end
end
