class Favoalb < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :album, optional: true
end
