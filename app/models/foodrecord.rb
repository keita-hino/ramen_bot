class Foodrecord < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :lineuser, foreign_key: 'userid', class_name: 'Lineuser',optional: true

  def self.food_search(lineuser_id:,store_name:,menu_name:,taste:,thickness:,hardness:,taste_intensity:,evalute:)
    q = Foodrecord.where(lineuser_id: lineuser_id)
    q = q.where(store_name: store_name)           if store_name.present?
    q = q.where(menu_name: menu_name)             if menu_name.present?
    q = q.where(taste: taste)                     if taste.present?
    q = q.where(thickness: thickness)             if thickness.present?
    q = q.where(hardness: hardness)               if hardness.present?
    q = q.where(taste_intensity: taste_intensity) if taste_intensity.present?
    q = q.where(evalute: (evalute).to_f..5)       if evalute.present?
    q = q.limit(10).order("evalute DESC")
    return q
  end

end
