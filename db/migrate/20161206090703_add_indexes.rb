class AddIndexes < ActiveRecord::Migration
  def change
    add_index :authentications, :user_id
    add_index :listings, :user_id
    add_index :reservations, :user_id
    add_index :reservations, :listing_id
    add_index :reservations, :payment_id
  end
end
