class Favopic < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :picture, optional: true

  validates :picture_id, null: false
  validates :user_id, null: false
end
