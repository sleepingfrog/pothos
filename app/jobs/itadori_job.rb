class ItadoriJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep(11)
    logger.info "itadori"
  end
end
