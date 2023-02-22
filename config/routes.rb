# frozen_string_literal: true

Rails.application.routes.draw do
  get 'about/index'
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :listings
  root 'listings#index'
  post 'listings/new', to: 'listings#create'
  post 'listings/:id/edit',to: 'listings#update', as: 'update_listing'
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new', :as => :login
  end
end
