class ReservationsController < ApplicationController
  before_action :require_login
  
  def show
  end

  def index
  end

  def new
    @reservation = Reservation.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    reservation_params_with_detail = reservation_params
    reservation_params_with_detail[:listing] = @listing
    reservation_params_with_detail[:user] = current_user
    @reservation = Reservation.new(reservation_params_with_detail)

 
      if @reservation.valid_date?
        if @reservation.save
          # Run "redis-server" then "bundle exec sidekiq" then "rails s" in this order.
          ReservationJob.perform_later(@reservation.user, @listing.user, @reservation.id)
          redirect_to new_listing_reservation_payment_url(@listing, @reservation)

        else
          render action: 'new'
        end
      else
        @reservation.errors.add(:date, "is not available.")
        render action: 'new'
      end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :total_cost)
  end
end
