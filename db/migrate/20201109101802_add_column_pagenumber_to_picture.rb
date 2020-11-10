class AddColumnPagenumberToPicture < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :pagenumber, :integer
  end
end
