class AddPicturesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :pictures, :json
  end
end
