class ItadoriJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "itadori"
  end
end
