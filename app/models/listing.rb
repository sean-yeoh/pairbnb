class Listing < ActiveRecord::Base
  belongs_to :user
  validates :city, presence: true
  validates :address, presence: true
  validates :num_guests, presence: true
  validates :num_bedrooms, presence: true
  validates :num_bathrooms, presence: true
  validates :price, presence: true
end
