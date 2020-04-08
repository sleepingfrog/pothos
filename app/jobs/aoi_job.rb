class AoiJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "aoi"
  end
end
