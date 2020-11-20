class CreateFavoalbs < ActiveRecord::Migration[5.2]
  def change
    create_table :favoalbs do |t|
      t.integer :user_id
      t.integer :album_id

      t.timestamps
    end
  end
end
