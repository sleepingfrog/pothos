module Author::Operation
  class Update < Trailblazer::Operation
    step Wrap( ->(options, &block){ Author.transaction do block.call end }){
      step Model(Author, :find)
      step Contract::Build(constant: Author::Contract::Edit)
      step Contract::Validate(key: "author")
      step :persist!
      fail :prepopulate!
    }

    def persist!(options, *)
      contract = options["contract.default"]
      contract.save
      contract.books.select{|book| book._delete.to_s == "1" }.each{|book| book.model.destroy }
    end

    def prepopulate!(options, *)
      options["contract.default"].prepopulate!
    end
  end
end
