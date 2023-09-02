# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    title { 'Sample Listing' }
    address { '123 Main St, Sample City' }
    price { 1000.0 }
    buy_or_rent { true }
    description { 'A lovely place to stay.' }
    user
  end
end
