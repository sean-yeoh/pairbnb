class ReservationsController < ApplicationController
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

    respond_to do |format|
      if @reservation.valid_date?
        if @reservation.save
          ReservationMailer.booking_email(@reservation.user, @listing.user, @reservation.id).deliver_now
          format.html { redirect_to @listing, notice: "Reservation was successfully created." }
        else
          format.html { render action: 'new' }
        end
      else
        @reservation.errors.add(:date, "is not available.")
        format.html { render action: 'new' }
      end
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
