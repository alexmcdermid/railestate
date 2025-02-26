# spec/requests/api/v1/listings_spec.rb
require 'swagger_helper'

RSpec.describe 'Listings API', type: :request do
  path '/api/v1/listings' do
    get 'Retrieves all listings' do
      tags 'Listings'
      produces 'application/json'
      security [ApiKeyAuth: []]

      response '200', 'listings found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Listing' }
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
