# frozen_string_literal: true
class CreateTables < ActiveRecord::Migration[5.2]
  def change
    unless table_exists?('attribute')
      create_table 'attribute', primary_key: 'attribute_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'name', limit: 100, null: false
      end
    end

    unless table_exists?('attribute_value')
      create_table 'attribute_value', primary_key: 'attribute_value_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'attribute_id', null: false
        t.string 'value', limit: 100, null: false
        t.index ['attribute_id'], name: 'idx_attribute_value_attribute_id'
      end
    end

    unless table_exists?('audit')
      create_table 'audit', primary_key: 'audit_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'order_id', null: false
        t.datetime 'created_on', null: false
        t.text 'message', null: false
        t.integer 'code', null: false
        t.index ['order_id'], name: 'idx_audit_order_id'
      end
    end

    unless table_exists?('category')
      create_table 'category', primary_key: 'category_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'department_id', null: false
        t.string 'name', limit: 100, null: false
        t.string 'description', limit: 1000
        t.index ['department_id'], name: 'idx_category_department_id'
      end
    end

    unless table_exists?('customer')
      create_table 'customer', primary_key: 'customer_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'name', limit: 50, null: false
        t.string 'email', limit: 100, null: false
        t.string 'password', limit: 50, null: false
        t.text 'credit_card'
        t.string 'address_1', limit: 100
        t.string 'address_2', limit: 100
        t.string 'city', limit: 100
        t.string 'region', limit: 100
        t.string 'postal_code', limit: 100
        t.string 'country', limit: 100
        t.integer 'shipping_region_id', default: 1, null: false
        t.string 'day_phone', limit: 100
        t.string 'eve_phone', limit: 100
        t.string 'mob_phone', limit: 100
        t.index ['email'], name: 'idx_customer_email', unique: true
        t.index ['shipping_region_id'], name: 'idx_customer_shipping_region_id'
      end
    end

    unless table_exists?('department')
      create_table 'department', primary_key: 'department_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'name', limit: 100, null: false
        t.string 'description', limit: 1000
      end
    end

    unless table_exists?('order_detail')
      create_table 'order_detail', primary_key: 'item_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'order_id', null: false
        t.integer 'product_id', null: false
        t.string 'attributes', limit: 1000, null: false
        t.string 'product_name', limit: 100, null: false
        t.integer 'quantity', null: false
        t.decimal 'unit_cost', precision: 10, scale: 2, null: false
        t.index ['order_id'], name: 'idx_order_detail_order_id'
      end
    end

    unless table_exists?('orders')
      create_table 'orders', primary_key: 'order_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.decimal 'total_amount', precision: 10, scale: 2, default: '0.0', null: false
        t.datetime 'created_on', null: false
        t.datetime 'shipped_on'
        t.integer 'status', default: 0, null: false
        t.string 'comments'
        t.integer 'customer_id'
        t.string 'auth_code', limit: 50
        t.string 'reference', limit: 50
        t.integer 'shipping_id'
        t.integer 'tax_id'
        t.index ['customer_id'], name: 'idx_orders_customer_id'
        t.index ['shipping_id'], name: 'idx_orders_shipping_id'
        t.index ['tax_id'], name: 'idx_orders_tax_id'
      end
    end

    unless table_exists?('product')
      create_table 'product', primary_key: 'product_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'name', limit: 100, null: false
        t.string 'description', limit: 1000, null: false
        t.decimal 'price', precision: 10, scale: 2, null: false
        t.decimal 'discounted_price', precision: 10, scale: 2, default: '0.0', null: false
        t.string 'image', limit: 150
        t.string 'image_2', limit: 150
        t.string 'thumbnail', limit: 150
        t.integer 'display', limit: 2, default: 0, null: false
        t.index %w[name description], name: 'idx_ft_product_name_description', type: :fulltext
      end
    end

    unless table_exists?('product_attribute')
      create_table 'product_attribute', primary_key: %w[product_id attribute_value_id], options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'product_id', null: false
        t.integer 'attribute_value_id', null: false
      end
    end

    unless table_exists?('product_category')
      create_table 'product_category', primary_key: %w[product_id category_id], options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'product_id', null: false
        t.integer 'category_id', null: false
      end
    end

    unless table_exists?('review')
      create_table 'review', primary_key: 'review_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.integer 'customer_id', null: false
        t.integer 'product_id', null: false
        t.text 'review', null: false
        t.integer 'rating', limit: 2, null: false
        t.datetime 'created_on', null: false
        t.index ['customer_id'], name: 'idx_review_customer_id'
        t.index ['product_id'], name: 'idx_review_product_id'
      end
    end

    unless table_exists?('shipping')
      create_table 'shipping', primary_key: 'shipping_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'shipping_type', limit: 100, null: false
        t.decimal 'shipping_cost', precision: 10, scale: 2, null: false
        t.integer 'shipping_region_id', null: false
        t.index ['shipping_region_id'], name: 'idx_shipping_shipping_region_id'
      end
    end

    unless table_exists?('shipping_region')
      create_table 'shipping_region', primary_key: 'shipping_region_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'shipping_region', limit: 100, null: false
      end
    end

    unless table_exists?('shopping_cart')
      create_table 'shopping_cart', primary_key: 'item_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'cart_id', limit: 32, null: false
        t.integer 'product_id', null: false
        t.string 'attributes', limit: 1000, null: false
        t.integer 'quantity', null: false
        t.boolean 'buy_now', default: true, null: false
        t.datetime 'added_on', null: false
        t.index ['cart_id'], name: 'idx_shopping_cart_cart_id'
      end
    end

    unless table_exists?('tax')
      create_table 'tax', primary_key: 'tax_id', id: :integer, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci', force: :cascade do |t|
        t.string 'tax_type', limit: 100, null: false
        t.decimal 'tax_percentage', precision: 10, scale: 2, null: false
      end
    end
  end
end
