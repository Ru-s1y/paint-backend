class Album < ApplicationRecord
  belongs_to :user, optional: true
  has_many :pictures

  def album_json
    as_json(only: [:id, :title, :description, :publish, :user_id])
  end
end
