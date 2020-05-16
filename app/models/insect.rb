class Insect < ApplicationRecord
  has_many :hotels, foreign_key: :guest_id
  has_many :works, foreign_key: :staff_id, class_name: :Hotel
  has_many :hevens, foreign_key: :food_id, class_name: :Hotel
end
