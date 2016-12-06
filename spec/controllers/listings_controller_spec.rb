require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

  let(:user) {User.create(name: "sean", email: "sean@hotmail.com", password: "12345678", role: 2)}
  let(:tenant) {User.create(name: "tenant", email: "tenant@hotmail.com", password: "12345678")}
  let(:valid_params) {{ 
    title: "Good place in PJ", 
    city: "PJ",
    address: "123, Jalan 3", 
    description: "Near to malls",
    num_guests: 4,
    num_bedrooms: 2,
    num_bathrooms: 2,
    price: 100.00}}

    let(:valid_params_update) {{ 
    title: "Good place in PJ", 
    city: "PJ",
    address: "123, Jalan 3", 
    description: "Near to malls",
    num_guests: 8,
    num_bedrooms: 4,
    num_bathrooms: 4,
    price: 200.00}}

    let(:invalid_params) {{ 
    title: "Good place in PJ", 
    city: "PJ",
    address: "", 
    description: "Near to malls",
    num_guests: 4,
    num_bathrooms: 2,
    price: 100.00}}

  describe "GET #new" do
    context "superadmin or landlord" do
      before do
        sign_in_as user
        get :new
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end

      it "assigns instance status" do
        expect(assigns[:listing]).to be_a Listing
      end
    end

    context "tenant" do
      before do
        sign_in_as tenant
        get :new
      end

      it "flash danger message" do
        expect(flash[:danger]).to include "Sorry. You are not allowed to perform this action as a tenant."
      end

      it "redirect to listings path" do
        expect(response).to redirect_to(listings_path)
      end
    end
  end

  describe "POST #create" do
    before do
      sign_in_as user
    end

    # happy_path
    context "valid_params" do
      it "creates new listing if params are correct" do
        expect {post :create, :listing => valid_params}.to change(Listing, :count).by(1)
      end

      it 'redirects listing path after listing is created successfully' do
        post :create, listing: valid_params
        expect(response).to redirect_to(Listing.last)
      end
    end

    # unhappy_path
    context "invalid_params" do
      before do
        sign_in_as user
        post :create, listing: invalid_params
      end

      it "renders new template again" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    context "superadmin or landlord" do
      before do
        sign_in_as user
        listing = user.listings.create(valid_params)
        get :edit, {:id => listing.to_param}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context "tenant" do
      before do
        sign_in_as tenant
        @listing = user.listings.create(valid_params)
        get :edit, {:id => @listing.to_param}
      end

      it "flash danger message" do
        expect(flash[:danger]).to include "Sorry. You can't edit this listing."
      end

      it "redirect to that listing path" do
        expect(response).to redirect_to(@listing)
      end
    end
  end

  describe "PUT #update" do
    before do
      sign_in_as user
    end

    # happy_path
    context "with valid update params" do
      it "updates the requested status" do
        @listing = user.listings.create(valid_params)
        put :update, {:id => @listing.to_param, :listing => valid_params_update}
        @listing.reload
        expect( @listing.price).to eq valid_params_update[:price]
      end

      it 'redirects to listing path' do
        @listing = user.listings.create(valid_params)
        put :update, {:id => @listing.to_param, :listing => valid_params_update}
        @listing.reload
        expect(response).to redirect_to(listing_path(@listing))
      end
    end
  end

  describe "DELETE #destroy" do
    context "superadmin or landlord" do
      before do
        sign_in_as user
      end

      it "destroys the particular listing" do
        listing = user.listings.create(valid_params)
        expect { delete :destroy, {:id => listing.to_param} }.to change(Listing, :count).by(-1)
      end

      it "redirects to the listings_paths" do
        listing = user.listings.create(valid_params)
        delete :destroy, {:id => listing.to_param}
        expect(response).to redirect_to(listings_path)
      end
    end

    context "tenant" do
      before do
        sign_in_as tenant
        @listing = user.listings.create(valid_params)
        delete :destroy, {:id => @listing.to_param}
      end

      it "flash danger message" do
        expect(flash[:danger]).to include "Sorry. You can't delete this listing."
      end

      it "redirect to listings_path" do
        expect(response).to redirect_to(listings_path)
      end
    end
  end 
end