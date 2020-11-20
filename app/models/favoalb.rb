class Favoalb < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :album, optional: true

  validates :album_id, null: false
  validates :user_id, null: false
end
