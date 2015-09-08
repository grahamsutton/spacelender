require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  test "the listing's name should not be empty" do
    listing = FactoryGirl.build(:listing, :name => nil)
    assert !listing.valid?, "The listing was saved without a Name."
  end

  test "the listing's name should be no less than 8 characters" do
    listing = FactoryGirl.build(:listing, :name => "x" * 7)
    assert !listing.valid?, "The listing was saved with less than the minimum allowed characters for the Name field."
  end

  test "the listing's name should be no more than the maximum allowed characters" do
    listing = FactoryGirl.build(:listing, :name => "x" * 121)
    assert !listing.valid?, "The listing was saved with more than the maximum allowed characters for the Name field."
  end

  test "the listing's description should not be empty" do
    listing = FactoryGirl.build(:listing, :description => nil)
    assert !listing.valid?, "The listing was saved without a description."
  end

  test "the listing's description should be no less than the minimum number of characters allowed" do
    listing = FactoryGirl.build(:listing, :description => "x" * 25)
    assert !listing.valid?, "The listing description was saved with less than the minimum number of characters necessary."
  end

  test "the listing's description should be no more than the maximum number of characters allowed" do
    listing = FactoryGirl.build(:listing, :description => "x" * 4001)
    assert !listing.valid?, "The listing description was saved with more than the maximum number of characters allowed."
  end
end
