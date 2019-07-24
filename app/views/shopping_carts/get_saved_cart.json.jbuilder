# frozen_string_literal: true

json.extract! @cart_item.first, :item_id, :name, :features, :price
