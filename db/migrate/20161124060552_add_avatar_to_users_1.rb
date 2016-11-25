class AddAvatarToUsers1 < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end
