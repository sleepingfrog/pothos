class Hotel < ApplicationRecord
  belongs_to :staff, class_name: :Insect
  belongs_to :guest, class_name: :Insect
  belongs_to :food, class_name: :Insect
end
