class AoiJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep(7)
    logger.info "aoi"
  end
end
