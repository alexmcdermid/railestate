class AdminController < ApplicationController
  before_action :verify

  def index
    @ahoy_events = Ahoy::Event.all
    @ahoy_visits = Ahoy::Visit.all
  end

  def verify
    if admin_emails.exclude?(current_user&.email)
      redirect_to root_path
    end
  end
end
