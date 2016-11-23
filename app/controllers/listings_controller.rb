class ListingsController < ApplicationController
  def index
    @listings = Listing.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @listing = Listing.new
  end

  def create
    listing_with_user = listing_params
    listing_with_user[:user] = current_user
    @listing = Listing.new(listing_with_user)

    if @listing.save
      redirect_to @listing
    else
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to @listing
    else 
      render 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to listings_path
  end

  private
  def listing_params
    params.require(:listing).permit(:city, :address, :description, :num_guests, :num_bedrooms, :num_bathrooms, :price, :availability)
  end
end
