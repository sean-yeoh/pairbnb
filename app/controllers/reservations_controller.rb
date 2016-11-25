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
    if @reservation.save
      redirect_to @listing
    else
      render 'new'
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
