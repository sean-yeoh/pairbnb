class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :city
      t.text :address
      t.text :description
      t.integer :num_guests
      t.integer :num_bedrooms
      t.integer :num_bathrooms
      t.decimal :price
      t.boolean :availability

      t.timestamps null: false
    end
  end
end
