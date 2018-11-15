class Lineuser < ApplicationRecord
  has_many :foodrecord, foreign_key: 'lineuser_id',primary_key: 'userid', class_name: 'Foodrecord'
end
