json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :size, :stock, :category
  json.url product_url(product, format: :json)
end
