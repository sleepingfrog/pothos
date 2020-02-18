module Author::Contract
  class Create < Reform::Form
    model :author

    property :name
    property :age

    validates :name, presence: true
    validates :age , presence: true

    books_prepopulator = ->(options){ books.append(Book.new) while books.size < 3 }
    books_populator = ->(options){ 
      if options[:fragment].values.all?(&:blank?)
        return skip!
      end
      books.append(Book.new)
    }
    collection :books, prepopulator: books_prepopulator, populator: books_populator do
      property :name
    end
  end
end
