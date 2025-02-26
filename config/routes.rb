# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get "about/index"
  get "admin/index"
  get "users/profile/show"
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :listings
  resources :photos
  root "listings#index"
  post "listings/new", to: "listings#create"
  post "listing/:id/destroy", to: "listing#destroy", as: "destroy_listing"
  post "listings/:id/edit", to: "listings#update", as: "update_listing"
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new", :as => :login
  end
  resources :users do
    member do
      post :generate_token
    end
  end 
  namespace :api do
    namespace :v1 do
      resources :listings, only: [:index]
    end
  end
end
