# frozen_string_literal: true

require "test_helper"

class ListingTest < ActiveSupport::TestCase
  test "should be valid" do
    listing = listings(:one)
    assert listing.valid?
  end

  # test "should generate a presigned URL if image_url is present" do
  #   listing = listings(:one)
  #   assert_not_nil listing.fetch_presigned_image_url_aws
  # end

  # Additional tests as needed...
end
