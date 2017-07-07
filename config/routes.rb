Rails.application.routes.draw do
  root to: 'home#index'

  get 'filter_properties', to: 'properties#filtered_properties'
end
