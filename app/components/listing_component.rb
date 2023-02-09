# frozen_string_literal: true

class ListingComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(listing:)
    super
    @listing = listing
  end
end
