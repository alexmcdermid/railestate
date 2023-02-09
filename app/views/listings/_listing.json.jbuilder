json.extract! listing, :id, :title, :address, :image_url, :price, :buy_or_rent, :description, :created_at, :updated_at
json.url listing_url(listing, format: :json)
