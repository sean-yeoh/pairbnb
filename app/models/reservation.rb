class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  validate :check_out_date_cannot_be_earlier_than_check_in_date

  before_save :total_cost

  def check_out_date_cannot_be_earlier_than_check_in_date
    if self.check_in_date >= self.check_out_date 
      errors.add(:check_out_date, "can't be earlier than check in date")
    end
  end

  def total_cost
    self.total_cost = (self.check_out_date.mjd - self.check_in_date.mjd) * self.listing.price.to_f unless (check_out_date.nil? || check_in_date.nil?) 
  end
end
