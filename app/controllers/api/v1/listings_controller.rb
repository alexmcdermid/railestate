class Api::V1::ListingsController < ApplicationController
  before_action :authenticate

  def index
    listings = Listing.all
    render json: listings, status: :ok
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      user = User.all.find do |u|
        if u.api_token.present?
          BCrypt::Password.new(u.api_token) == token
        else
          false
        end
      end
      user.present?
    end
  end
end
