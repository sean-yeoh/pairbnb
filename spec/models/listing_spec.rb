require "rails_helper"

RSpec.describe Listing, :type => :model do
  context "validations" do
    it "should have title and content and user_id" do
      should have_db_column(:city).of_type(:string)
      should have_db_column(:address).of_type(:text)
      should have_db_column(:description).of_type(:text)
      should have_db_column(:user_id).of_type(:integer)
      should have_db_column(:num_guests).of_type(:integer)
      should have_db_column(:num_bedrooms).of_type(:integer)
      should have_db_column(:num_bathrooms).of_type(:integer)
      should have_db_column(:price).of_type(:decimal)
      should have_db_column(:title).of_type(:string)
      should have_db_column(:pictures).of_type(:json)
    end

    describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:num_guests) }
      it { is_expected.to validate_presence_of(:num_bathrooms) }
      it { is_expected.to validate_presence_of(:num_bedrooms) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_presence_of(:title) }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:reservations).dependent(:destroy) }
  end
end
