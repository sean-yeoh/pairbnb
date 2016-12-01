class WelcomeController < ApplicationController
  def index
    @user = User.new
    @cities = Listing.uniq.pluck(:city)
  end
end
