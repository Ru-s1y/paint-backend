class User < ApplicationRecord
  include UserAuth::Tokenizable
  has_secure_password
  
  has_many :rooms
  has_many :messages
  has_many :albums
  has_many :pictures

  def my_json
    as_json(only: [:id, :name])
  end
end
