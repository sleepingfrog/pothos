class Gift < ApplicationRecord
  extend Enumerize

  enumerize :wrapping, in: %w[no_wrap ribbon paper bag non_woven_fabric]
end
