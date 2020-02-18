module Author::Contract
  class Edit < Reform::Form
    model :author

    property :name
    property :age

    validates :name, presence: true
    validates :age , presence: true

    books_prepopulator = ->(options){ books.append(Book.new) while books.size < 3 }
    books_populator = ->(options){ 
      item = if options.dig(:fragment, :id).present?
               books.find { |book| book.id.to_s == options[:fragment][:id].to_s }
             else
               nil
             end

      if options.dig(:fragment, :_delete).to_s == "1"
        if item
          item.model.mark_for_destruction
        end
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

      property :_delete, virtual: true
    end
  end
end
