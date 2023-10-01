# frozen_string_literal: true

class UsersController < ApplicationController
  def generate_token
    @token = current_user.generate_api_token
  
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to profile_path, notice: 'Token generated' }
    end
  end
end
