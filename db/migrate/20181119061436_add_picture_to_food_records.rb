class AddPictureToFoodRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :foodrecords, :picture, :string
  end
end
