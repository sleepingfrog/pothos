module Author::Contract
  class Create < Reform::Form
    model :author

    property :name
    property :age

    validates :name, presence: true
    validates :age , presence: true
  end
end
