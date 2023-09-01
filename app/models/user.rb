class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for google oauth
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :listings, dependent: :destroy
end
