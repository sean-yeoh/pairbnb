class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :braintree_transaction_id

      t.timestamps null: false
    end
  end
end
