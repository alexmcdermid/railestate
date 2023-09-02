# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listing, type: :model do
  it 'should create a valid listing' do
    listing = build(:listing)
    expect(listing).to be_valid
  end

  it 'should return nil if image_url is absent' do
    listing = create(:listing, image_url: nil)
    expect(listing.get_image_url).to be_nil
  end

  # also test using fixtures in rspec
  it 'should be valid' do
    listing = listings(:one)
    assert listing.valid?
  end
end
