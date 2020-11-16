class User < ApplicationRecord
  include UserAuth::Tokenizable
  has_secure_password
  
  has_many :rooms
  has_many :messages
  has_many :albums
  has_many :pictures

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def my_json
    as_json(only: [:id, :name])
  end
end
