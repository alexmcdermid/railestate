# frozen_string_literal: true

Rails.application.routes.draw do
  get 'about/index'
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :listings
  resources :photos
  root 'listings#index'
  post 'listings/new', to: 'listings#create'
  post 'listing/:id/destroy', to: 'listing#destroy', as: 'destroy_listing'
  post 'listings/:id/edit', to: 'listings#update', as: 'update_listing'
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new', :as => :login
  end
end
