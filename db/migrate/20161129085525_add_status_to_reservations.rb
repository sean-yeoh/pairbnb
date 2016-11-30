class AddStatusToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :status, :boolean, default: false
  end
end
