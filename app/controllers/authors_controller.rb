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
    result = Author::Operation::Update.call(params: params)
    if result.success?
      redirect_to :authors
    else
      @author = result["contract.default"]
      render :edit
    end
  end
end
