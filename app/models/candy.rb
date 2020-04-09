class Candy < ApplicationRecord
  include CandyWrapPaperUploader::Attachment(:wrap_paper)

  after_save do
    wrap_paper_derivatives! if wrap_paper.present?
  end
end
