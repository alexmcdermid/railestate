# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for google oauth
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
  has_many :listings, dependent: :destroy

  def self.from_omniauth(auth)
    # Try to find a user first by provider and uid
    user = where(provider: auth.provider, uid: auth.uid).first

    # If no user is found, find by email
    unless user
      user = where(email: auth.info.email).first

      # If user is found, update their provider and uid
      user&.update(provider: auth.provider, uid: auth.uid)
    end

    # Create a new user if neither is found
    user ||= create(
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      provider: auth.provider,
      uid: auth.uid,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    )

    user
  end
end
