class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :pictures, :album_id, true
  end

  def down
    change_column_null :pictures, :album_id, false
  end
end
