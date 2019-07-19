# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :departments, defaults: { format: :json } do
    get '/', to: 'departments#index'
    get '/:department_id', to: 'departments#show'
  end
end
