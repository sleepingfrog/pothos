class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.references :staff, null: false, foreign_key: { to_table: :insects }
      t.references :guest, null: false, foreign_key: { to_table: :insects }
      t.references :food, null: false, foreign_key: { to_table: :insects }

      t.timestamps
    end
  end
end
