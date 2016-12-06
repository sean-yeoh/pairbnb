require "rails_helper"

RSpec.describe User, :type => :model do

  let(:name) { "sean" }
  let(:email) { "sean@hotmail.com" }
  let(:password) { "12345678" }
  let(:sean) { User.new(name: name, email: email, password: password) }

  context "valid input" do
    
    describe "can be created when all attributes are present and valid" do      

      it "saves the user" do
        expect(sean).to be_valid
      end

      it "increase user db count by 1" do
        user_db_count = User.count
        sean.save
        expect(User.count).to eq(user_db_count+1)
      end
    end
  end

  context "ivalid input" do

    describe "can't be created with invalid input" do

      it "with no name" do
        invalid_user = User.create(email: "sean@hotmail.com", password: "12345678")
        expect(invalid_user).to_not be_valid
      end

      it "with no email" do
        invalid_user = User.create(name: "sean", password: "12345678")
        expect(invalid_user).to_not be_valid
      end

      it "with no password" do
        invalid_user = User.create(name: "", email: "sean@hotmail.com")
        expect(invalid_user).to_not be_valid
      end

      it "with invalid email" do
        invalid_user = User.create(name: "", email: "seanhotmail.com")
        expect(invalid_user).to_not be_valid
      end

      it "with email that has been taken" do
        valid_user = User.create(name: "sean", email: "sean@hotmail.com", password: "12345678")
        invalid_user = User.create(name: "yeoh", email: "sean@hotmail.com", password: "12345678")
        expect(invalid_user).to_not be_valid
      end

      it "with password length less than 8" do
        invalid_user = User.create(name: "sean", email: "sean@hotmail.com", password: "1234567")
        expect(invalid_user).to_not be_valid
      end
    end
  end

  context "associations with dependency" do
    let(:name) { "test" }
    let(:email) { "test@hotmail.com" }
    let(:password) { "12345678" }
    let(:user) { User.create(name: name, email: email, password: password) }

    describe "listings" do

      let(:listing1) { user.listings.new(
      title: "Goood place in PJ",
      city: "PJ", 
      address: "123, Jalan 3", 
      description: "Near to malls",
      num_guests: 4,
      num_bedrooms: 2,
      num_bathrooms: 2,
      price: 100.00) }

      let(:listing2) { user.listings.new(
      title: "Goood place in Bangsar",
      city: "Bangsar", 
      address: "123, Jalan 5", 
      description: "Near to lrt",
      num_guests: 4,
      num_bedrooms: 2,
      num_bathrooms: 2,
      price: 100.00) }

      it "should have many listings" do
        listing1.save
        listing2.save
        expect(user.listings).to eq([listing1, listing2])
      end

      it "should have dependent destroy" do
        listing1.save
        listing2.save
        expect { user.destroy }.to change { Listing.count }.by(-2)
      end
    end

    describe "reservations" do
      it { is_expected.to have_many(:reservations).dependent(:destroy) }
    end
  end
end
