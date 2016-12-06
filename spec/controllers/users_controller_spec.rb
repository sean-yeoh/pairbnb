require 'rails_helper'
require 'clearance'

RSpec.describe UsersController, type: :controller do

let(:valid_params) {{ name: "Sean", email: "sean@gmail.com", password: "12345678"}}
let(:invalid_params) {{ name: "Sean", email: "sean.com", password: "12345678"}}
let(:user1) { User.new(valid_params) }

describe "GET #new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns instance user" do
      expect(assigns[:user]).to be_a User
    end
  end

  describe "POST #create" do
    # happy_path
    context "with valid attributes" do
      it "assigns and creates a user" do
        old_user_count = User.count

        xhr :post, :create, user: valid_params

        expect(assigns(:user)).to be_present
        expect(User.count).to eq old_user_count + 1
        expect(response).to be_ok
      end

      it "logs in the new user" do
        xhr :post, :create, user: valid_params
        expect(request.env[:clearance].signed_in?).to be true
      end
    end

    context "with invalid attributes" do
      before do
        xhr :post, :create, user: invalid_params
      end

      it "returns render users/create.js.erb" do
        expect(response).to be_ok
      end
    end
  end
end