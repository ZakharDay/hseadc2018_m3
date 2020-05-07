json.extract! favourite_product, :id, :user_id, :product_id, :created_at, :updated_at
json.url favourite_product_url(favourite_product, format: :json)
