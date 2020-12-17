class RemoveImageFromPictures < ActiveRecord::Migration[5.2]
  def up
    remove_column :pictures, :image, :string
  end

  def down
    add_column :pictures, :image, :string
  end
end
