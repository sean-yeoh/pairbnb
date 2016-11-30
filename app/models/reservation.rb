class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :payment
  validate :check_out_date_cannot_be_earlier_than_check_in_date

  before_save :total_cost

  def check_out_date_cannot_be_earlier_than_check_in_date
    if self.check_in_date >= self.check_out_date 
      errors.add(:check_out_date, "can't be earlier than check in date")
    end
  end

  def total_cost
    self.total_cost = nights * self.listing.price.to_f unless (check_out_date.nil? || check_in_date.nil?) 
  end

  def range
    (self.check_in_date...self.check_out_date).to_a
  end

  def nights
    (self.check_out_date.mjd - self.check_in_date.mjd)
  end

  def valid_date?
    valid = true
    self.listing.reservations.each do |reservation|
      next if self == reservation
      unless (self.range + reservation.range).uniq == (self.range + reservation.range)
        valid = false
      end
    end
    return valid

    # can also use a_range & b_range to return intersecting dates
    # arr_a & arr_b -> return [value] if have intersecting value else return [] (empty arr)
  end
end
