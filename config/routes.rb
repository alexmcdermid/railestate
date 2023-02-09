# frozen_string_literal: true

Rails.application.routes.draw do
  resources :listings
  root 'listings#index'
  post 'listings/new', to: 'listings#create'
end
