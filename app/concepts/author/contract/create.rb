module Author::Contract
  class Create < Reform::Form
    model :author

    property :name
    property :age

    validates :name, presence: true
    validates :age , presence: true

    books_prepopulator = ->(options){ books.append(Book.new) while books.size < 3 }
    collection :books, prepopulator: books_prepopulator, populate_if_empty: Book do
      property :name
    end
  end
end
