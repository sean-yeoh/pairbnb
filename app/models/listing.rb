class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, :dependent => :destroy
  validates :city, presence: true
  validates :address, presence: true
  validates :num_guests, presence: true
  validates :num_bedrooms, presence: true
  validates :num_bathrooms, presence: true
  validates :price, presence: true
  mount_uploaders :pictures, PicturesUploader

  scope :num_bedrooms, -> (num_bedrooms) { where num_bedrooms: num_bedrooms }
  scope :city, -> (city) { where city: city }
  
end
