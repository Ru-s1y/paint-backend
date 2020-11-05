class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.string :password_digest
      t.text :description
      t.boolean :publish, null: false, default: true
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
