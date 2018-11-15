class Foodrecord < ApplicationRecord
  belongs_to :lineuser, foreign_key: 'userid',primary_key: 'lineuser_id', class_name: 'Lineuser'
end
