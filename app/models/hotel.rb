class Hotel < ApplicationRecord
  belongs_to :staff
  belongs_to :guest
  belongs_to :food
end
