class UmeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "ume"
  end
end
