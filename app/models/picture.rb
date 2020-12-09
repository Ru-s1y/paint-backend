class Picture < ApplicationRecord
  belongs_to :album, optional: true
  belongs_to :user, optional: true
  has_many :favopics

  # mount_uploader :image, ImageUploader
  def self.search(search)
    return Picture.where(publish: true).order(updated_at: :DESC) unless search
    Picture.where(['title LIKE ?', "%#{search}%"]).where(publish: true).order(updated_at: :DESC)
  end

  def self.mysearch(search, user)
    return Picture.where(user_id: user.id).order(updated_at: :DESC) unless search
    Picture.where(['title LIKE ?', "%#{search}%"]).where(user_id: user.id).order(updated_at: :DESC)
  end
end
