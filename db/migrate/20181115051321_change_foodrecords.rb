class ChangeFoodrecords < ActiveRecord::Migration[5.1]
  def change
    add_column :foodrecords, :lineuser_id, :text
  end
end
