class CreateFoodrecords < ActiveRecord::Migration[5.1]
  def change
    create_table :foodrecords do |t|
      t.string :store_name
      t.string :menu_name
      t.string :taste
      t.string :thickness
      t.string :hardness
      t.string :taste_intensity
      t.integer :evalute

      t.timestamps
    end
  end
end
