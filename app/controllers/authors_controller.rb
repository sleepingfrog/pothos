class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def new
    @author = Author::Contract::Create.new(Author.new)
  end

  def create
    @author = Author::Contract::Create.new(Author.new)
    if @author.validate(params[:author])
      @author.save
      redirect_to :authors
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
