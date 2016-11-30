class AddPaymentRefToReservations < ActiveRecord::Migration
  def change
    add_reference :reservations, :payment, foreign_key: true
    add_column :reservations, :status, :string
  end
end
