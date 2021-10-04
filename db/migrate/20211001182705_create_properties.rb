class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false, limit: 128
      t.integer :property_type, null: false
      t.string :street, null: false, limit: 128
      t.string :external_number, null: false, limit: 12
      t.string :internal_number, limit: 12
      t.string :neighborhood, null: false, limit: 128
      t.string :city, null: false, limit: 64
      t.string :country, null: false, limit: 2
      t.integer :rooms, null: false
      t.float :bathrooms, null: false
      t.string :comments, null: true
      t.timestamps
    end
  end
end
