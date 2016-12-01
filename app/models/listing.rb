class Listing < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_many :reservations, :dependent => :destroy
  validates :city, presence: true
  validates :address, presence: true
  validates :num_guests, presence: true
  validates :num_bedrooms, presence: true
  validates :num_bathrooms, presence: true
  validates :price, presence: true
  validates :title, presence: true
  mount_uploaders :pictures, PicturesUploader

  pg_search_scope :search_by_description, :against => :description
  pg_search_scope :search_by_city_and_address, :against => [:city, :address]
  scope :num_bedrooms, -> (num_bedrooms) { where num_bedrooms: num_bedrooms }
  scope :num_guests, -> (num_guests) { where num_guests: num_guests }
  scope :num_bathrooms, -> (num_bathrooms) { where num_bathrooms: num_bathrooms }
  scope :min_price, ->(min_price) { where("price >= ?", min_price) }
  scope :max_price, ->(max_price) { where("price <= ?", max_price) }
  scope :city, -> (city) { where("city ILIKE ?", "%#{city}%") }

  
end
