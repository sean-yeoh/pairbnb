class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date
      t.decimal :total_cost
      
      t.timestamps null: false
    end
  end
end
