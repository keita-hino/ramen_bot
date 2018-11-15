class Foodrecord < ApplicationRecord
  belongs_to :lineuser, foreign_key: 'userid', class_name: 'Lineuser',optional: true
end
