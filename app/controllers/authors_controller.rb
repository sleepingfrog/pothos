class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def new
    @author = Author::Contract::Create.new(Author.new)
    @author.prepopulate!
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
    @author = Author::Contract::Edit.new(Author.find(params[:id]))
    @author.prepopulate!
  end

  def update
    @author = Author::Contract::Edit.new(Author.find(params[:id]))
    if @author.validate(params[:author])
      Author.transaction do
        @author.save
        @author.books.select{|book| book.model.marked_for_destruction? }.each{|book| book.model.destroy}
      end
      redirect_to :authors
    else
      render :edit
    end
  end
end
