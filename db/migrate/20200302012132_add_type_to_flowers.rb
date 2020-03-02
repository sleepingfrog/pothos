class AddTypeToFlowers < ActiveRecord::Migration[6.0]
  def change
    add_column :flowers, :type, :string
    add_index  :flowers, :type
  end
end
