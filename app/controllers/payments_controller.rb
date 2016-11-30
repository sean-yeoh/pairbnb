class PaymentsController < ApplicationController
  before_action :require_login

  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    @client_token = Braintree::ClientToken.generate
    @payment = Payment.new
  end

  def show
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    nonce = params["payment-method-nonce"]

    result = Braintree::Transaction.sale(
      amount: @reservation.total_cost,
      :merchant_account_id => "pairbnb",
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )


    redirect_to @listing

    # if result.success? || result.transaction
    #   redirect_to checkout_path(result.transaction.id)
    # else
    #   error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
    #   flash[:error] = error_messages
    #   redirect_to new_checkout_path
    # end
  end
end
