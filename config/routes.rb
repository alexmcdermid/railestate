# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :listings
  root 'listings#index'
  post 'listings/new', to: 'listings#create'
  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
end
