class AdminController < ApplicationController
  include Pagy::Backend
  before_action :verify

  def index
    @pagy, @ahoy_events = pagy(Ahoy::Event.all)
    @pagy, @ahoy_visits = pagy(Ahoy::Visit.all)
  end

  def verify
    if admin_emails.exclude?(current_user&.email)
      redirect_to root_path
    end
  end
end
