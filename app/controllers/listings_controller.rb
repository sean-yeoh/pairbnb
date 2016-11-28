class ListingsController < ApplicationController
  before_action :require_login

  def index
    @listings = Listing.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @listing = Listing.new
    if current_user.tenant?
      flash[:danger] = "Sorry. You are not allowed to perform this action as a tenant."
      return redirect_to listings_path
    end
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
    unless (current_user.superadmin? || current_user == @listing.user) && !current_user.tenant?
      flash[:danger] = "Sorry. You can't edit this listing."
      redirect_to :back
    end
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
    unless (current_user.superadmin? || current_user == @listing.user) && !current_user.tenant?
      flash[:danger] = "Sorry. You can't delete this listing."
      redirect_to :back
    else
      @listing.destroy
      redirect_to listings_path
    end
  end

  private
  def listing_params
    params.require(:listing).permit(:title, :city, :address, :description, :num_guests, :num_bedrooms, :num_bathrooms, :price, :availability, {pictures: []})
  end
end
