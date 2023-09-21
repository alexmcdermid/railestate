class AdminController < ApplicationController
  before_action :verify

  def index
  end

  def verify
    if admin_emails.exclude?(current_user&.email)
      redirect_to root_path
    end
  end
end
