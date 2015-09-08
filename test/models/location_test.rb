require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "the street address should not be blank" do
    location = FactoryGirl.build(:location, :street_address => nil)
    assert !location.valid?, "The location was saved without an address."
  end

  test "the city should not be blank" do
    location = FactoryGirl.build(:location, :city => nil)
    assert !location.valid?, "The location was saved without a city name provided."
  end

  test "the state should not be blank" do
    location = FactoryGirl.build(:location, :state => nil)
    assert !location.valid?, "The location was saved without a state name provided."
  end

  test "the country should not be blank" do
    location = FactoryGirl.build(:location, :country => nil)
    assert !location.valid?, "The location was saved without a country name provided."
  end

  test "the zip should not be blank" do
    location = FactoryGirl.build(:location, :zip => nil)
    assert !location.valid?, "The location was saved without a zip provided."
  end

  test "the address provided should be a valid address" do
    #FactoryGirl.
  end
end
