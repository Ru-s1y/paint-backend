class Album < ApplicationRecord
  belongs_to :user, optional: true
  has_many :pictures
  has_many :favoalbs

  def album_json
    as_json(only: [:id, :title, :description, :publish, :user_id])
  end

  def self.search(search)
    return Album.where(publish: true) unless search
    Album.where(['title LIKE ?', "%#{search}%"]).where(publish: true)
  end

  def self.mysearch(search, user)
    return Album.where(user_id: user.id) unless search
    Album.where(['title LIKE ?', "%#{search}%"]).where(user_id: user.id)
  end
end
