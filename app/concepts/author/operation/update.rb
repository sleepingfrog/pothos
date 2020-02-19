module Author::Operation
  class Update < Trailblazer::Operation
    step Wrap( ->(options, &block){ Author.transaction do block.call end }){
      step :set_model!
      step Contract::Build(constant: Author::Contract::Edit)
      step Contract::Validate(key: "author")
      step :persist!
      fail :prepopulate!
    }

    def set_model!(options, *)
      options["model"] = Author.lock.find(options[:params][:id])
    end

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
