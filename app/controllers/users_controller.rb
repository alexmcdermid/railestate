# frozen_string_literal: true

class UsersController < ApplicationController
  def generate_token
    token = SecureRandom.urlsafe_base64(24)
    hashed_token = BCrypt::Password.create(token)
    current_user.update(api_token: hashed_token)
  
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to profile_path, notice: 'Token generated' }
    end
  end
end
