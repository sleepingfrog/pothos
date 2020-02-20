class CandiesController < ApplicationController
  def index
    @candies = Candy.all
  end

  def new
    @candy = Candy.new
  end

  def create
    @candy = Candy.new(candy_params)
    if @candy.valid?
      @candy.wrap_paper_derivatives! if @candy.wrap_paper.present?
      @candy.save!
      redirect_to candy_path(@candy)
    else
      render :new
    end
  end

  def show
    @candy = Candy.find(params[:id])
  end

  private
  def candy_params
    params.require(:candy).permit(:name, :price, :wrap_paper)
  end
end
