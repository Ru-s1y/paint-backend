class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :title, null: false
      t.string :description
      t.string :image
      t.string :image_path
      t.boolean :publish, null: false, default: true
      t.integer :album_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
