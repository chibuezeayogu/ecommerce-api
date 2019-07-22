# frozen_string_literal: true

rows = []
@response.includes(:products).limit(product_limit).offset(product_offset).each do |category|
  category.products.each do |product|
    rows << {
      product_id: product.product_id,
      name: product.name,
      description: product.description.truncate(description_length),
      price: product.price,
      discounted_price: product.discounted_price,
      thumbnail: product.thumbnail
    }
  end
end

json.count rows.count
json.rows rows do |row|
  json.product_id row[:product_id]
  json.name row[:name]
  json.description row[:description]
  json.price row[:price]
  json.discounted_price row[:discounted_price]
  json.thumbnail row[:thumbnail]
end
