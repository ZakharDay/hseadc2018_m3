json.extract! product_item, :id, :product_id, :color_id, :serial_number, :created_at, :updated_at
json.url product_item_url(product_item, format: :json)
