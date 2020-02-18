module Author::Contract
  class Edit < Reform::Form
    model :author

    property :name
    property :age

    validates :name, presence: true
    validates :age , presence: true

    books_prepopulator = ->(options){ books.append(Book.new) while books.size < 3 }
    books_populator = ->(options){ 
      item = books.find { |book| book.id.to_s == options.dig(:fragment, :id).to_s }

      if options[:fragment].values.all?(&:blank?)
        return skip!
      end

      if item
        item
      else
        books.append(Book.new)
      end
    }
    collection :books, prepopulator: books_prepopulator, populator: books_populator do
      property :name
    end
  end
end
