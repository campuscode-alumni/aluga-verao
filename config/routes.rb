Rails.application.routes.draw do
  root to: 'home#index'

  get 'filter_properties', to: 'properties#filter_properties'
end
