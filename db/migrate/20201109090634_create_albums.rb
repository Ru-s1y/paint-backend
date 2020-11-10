class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.string :description
      t.boolean :publish, null: false, default: true
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
