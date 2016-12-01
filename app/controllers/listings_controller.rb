class ListingsController < ApplicationController
  before_action :require_login

  def home_search
    @listings = Listing.where(nil)
    home_search_params(params).each do |key, value|
      @listings = @listings.key if value.present?
    end
  end 

  def search
    @listings = Listing.paginate(:page => params[:page], :per_page => 6).where(nil)
    search_params(params).each do |key, value|
      @listings = @listings.public_send(key, value) if value.present?
    end
    
    @cities = Listing.uniq.pluck(:city)

    if @listings.empty?
      @notice = "No record found. Please search again."
    end
    render template: 'listings/index'

  end 

  def index
    @listings = Listing.paginate(:page => params[:page], :per_page => 6)
    @cities = Listing.uniq.pluck(:city)
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

  def search_params(params)
    params.slice(:city, :num_guests, :check_in_date, :check_out_date, :min_price, :max_price, :num_bathrooms, :num_bedrooms, :search_by_city_and_address)
  end
end
