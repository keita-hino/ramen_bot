class Foodrecord < ApplicationRecord
  mount_uploader :picture, PictureUploader

  ####################################
  # リレーション
  ####################################
  belongs_to :lineuser, foreign_key: 'userid', class_name: 'Lineuser',optional: true


  ####################################
  # バリデーション
  ####################################
  validates :store_name, presence: true
  validates :menu_name, presence: true


  ####################################
  # スコープ
  ####################################
  scope :lineuser_id_is, -> (lineuser_id) { where(lineuser_id:lineuser_id) }

  scope :store_name_match, -> (store_name) { where('store_name like ?', "%#{store_name}%") }

  scope :menu_name_match, -> (menu_name) { where('menu_name like ?', "%#{menu_name}%" ) }

  scope :taste_is, -> (taste) { where(taste:taste) }

  scope :thickness_is, -> (thickness) { where(thickness:thickness) }

  scope :hardness_is, -> (hardness) { where(hardness:hardness) }

  scope :taste_intensity_is, -> (taste_intensity) { where(taste_intensity:taste_intensity) }

  scope :evalute_is, -> (evalute) { where(evalute:(evalute).to_f..5) }


  ####################################
  # メソッド
  ####################################
  def self.food_search(lineuser_id:,store_name:,menu_name:,taste:,thickness:,hardness:,taste_intensity:,evalute:)
    query = Foodrecord.all
    query = query.lineuser_id_is(lineuser_id)
    query = query.store_name_match(store_name)        if store_name.present?
    query = query.menu_name_match(menu_name)          if menu_name.present?
    query = query.taste_is(taste)                     if taste.present?
    query = query.thickness_is(thickness)             if thickness.present?
    query = query.hardness_is(hardness)               if hardness.present?
    query = query.taste_intensity_is(taste_intensity) if taste_intensity.present?
    query = query.evalute_is(evalute)                 if evalute.present?
    query = query.limit(10).order("evalute DESC")
    return query
  end

end
