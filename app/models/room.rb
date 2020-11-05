class Room < ApplicationRecord
  has_secure_password

  belongs_to :user, optional: true
  has_many :messages

end
