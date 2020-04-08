class UmeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep(13)
    logger.info "ume"
  end
end
