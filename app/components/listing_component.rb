# frozen_string_literal: true

class ListingComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(listing:, user_signed_in:)
    super
    @listing = listing
    @user_signed_in = user_signed_in
  end
end
