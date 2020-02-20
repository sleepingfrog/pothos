class Candy < ApplicationRecord
  include CandyWrapPaperUploader::Attachment(:wrap_paper)
end
