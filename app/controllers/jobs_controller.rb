class JobsController < ApplicationController
  def index
  end

  def aoi
    7.times do
      AoiJob.perform_later
    end
  end

  def itadori
    11.times do
      ItadoriJob.perform_later
    end
  end

  def ume
    13.times do
      UmeJob.perform_later
    end
  end
end
