# frozen_string_literal: true

class ListingComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(listing:, user_signed_in:, user:)
    super
    @listing = listing
    @user_signed_in = user_signed_in
    @listing_creator = User.find(listing.user_id)
    @user = user
  end
end
