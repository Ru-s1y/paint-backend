class CreateFavopics < ActiveRecord::Migration[5.2]
  def change
    create_table :favopics do |t|
      t.integer :user_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
