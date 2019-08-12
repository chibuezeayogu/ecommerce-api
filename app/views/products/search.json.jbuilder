if @search_result.empty?
  json.error do
    json.set! :status, 404
    json.set! :code, 'PRO_02'
    json.set! :message, 'Product(s) not found'
    json.set! :field, 'product'
  end
else
  json.count @search_result.count
  json.rows @search_result.limit(product_limit).offset(product_offset), :product_id, :name, :description, :price, :discounted_price, :thumbnail
end
