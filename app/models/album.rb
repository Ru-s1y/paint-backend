class Album < ApplicationRecord
  belongs_to :user, optional: true
  has_many :pictures

  def album_json
    as_json(only: [:id, :title, :description, :publish, :user_id])
  end

  def self.search(search)
    return Album.where(publish: true) unless search
    Album.where(['title LIKE ?', "%#{search}%"]).where(publish: true)
  end
end
