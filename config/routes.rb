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

  match "/404", :to => "errors#route_not_found", :via => :all
end
