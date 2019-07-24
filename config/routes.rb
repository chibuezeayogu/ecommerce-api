# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :departments, defaults: { format: :json } do
    get '/', to: 'departments#index'
    get '/:department_id', to: 'departments#show'
  end
  scope path: :categories, defaults: { format: :json } do
    get '/', to: 'categories#index'
    get '/inProduct/:product_id', to: 'categories#in_product'
    get '/inDepartment/:department_id', to: 'categories#in_department'
    get '/:category_id', to: 'categories#show'
  end
  scope path: :attributes, defaults: { format: :json } do
    get '/', to: 'attributes#index'
    get '/:attribute_id', to: 'attributes#show'
    get '/values/:attribute_id', to: 'attributes#values'
    get '/inProduct/:product_id', to: 'attributes#in_product'
  end
  scope path: :products, defaults: { format: :json } do
    get '/', to: 'products#index'
    get '/:product_id', to: 'products#show'
    get '/inCategory/:category_id', to: 'products#in_category'
    get '/inDepartment/:department_id', to: 'products#in_department'
    get '/:product_id/details', to: 'products#details'
    get '/:product_id/locations', to: 'products#location'
    get '/:product_id/reviews', to: 'products#reviews'
    post '/:product_id/reviews', to: 'products#post_review'
  end
  scope path: :customers, defaults: { format: :json } do
    post '/', to: 'customers#create'
    post '/login', to: 'customers#login'
    post '/facebook', to: 'customers#facebook_login'
    put '/address', to: 'customers#update_customer_info'
    put '/creditCard', to: 'customers#update_credit_card'
  end
  scope path: :orders, defaults: { format: :json } do
    post '/', to: 'orders#create'
    get '/inCustomer', to: 'orders#show_customer_orders'
    get '/:order_id', to: 'orders#show'
    get '/showDetail/:order_id', to: 'orders#short_details'
  end
  scope path: :tax, defaults: { format: :json } do
    get '/', to: 'taxes#index'
    get '/:tax_id', to: 'taxes#show'
  end
  scope path: 'shipping/regions', defaults: { format: :json } do
    get '/', to: 'shippings#index'
    get '/:shipping_region_id', to: 'shippings#show'
  end
  scope path: :shoppingcart, defaults: { format: :json } do
    get '/generateUniqueId', to: 'shopping_carts#generate_cart_id'
    post '/add', to: 'shopping_carts#create'
    get '/:cart_id', to: 'shopping_carts#show'
    put '/update/:item_id', to: 'shopping_carts#update_cart'
    get '/totalAmount/:cart_id', to: 'shopping_carts#total_amount'
    get '/getSaved/:cart_id', to: 'shopping_carts#get_saved_cart'
    delete '/empty/:cart_id', to: 'shopping_carts#delete_cart'
    delete '/removeProduct/:item_id', to: 'shopping_carts#remove_product_from_cart'
  end

  match "/404", :to => "errors#route_not_found", :via => :all
end
