class HotelsController < ApplicationController
  def index
    @search = Form::SearchHotel.new search_hotel_params
    @hotels = @search.search
    puts @hotels.explain
  end

  private
  def search_hotel_params
    params.fetch(:form_search_hotel, {}).permit(:food, :guest, :staff)
  end
end
