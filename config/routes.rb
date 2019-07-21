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
end