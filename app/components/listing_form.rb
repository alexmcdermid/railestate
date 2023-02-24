# frozen_string_literal: true

class ListingForm < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(listing:)
    super
    @listing_object = listing
  end
end
