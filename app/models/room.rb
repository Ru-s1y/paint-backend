class Room < ApplicationRecord
  has_secure_password

  belongs_to :user, optional: true
  has_many :messages

  def self.search(search)
    return Room.all unless search
    Room.where(['name LIKE ?', "%#{search}%"])
  end
end
