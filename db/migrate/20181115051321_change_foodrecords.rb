class ChangeFoodrecords < ActiveRecord::Migration[5.1]
  def change
    change_column :foodrecords, :lineuser_id, :text
  end
end
