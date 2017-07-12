Rails.application.routes.draw do
  root to: 'home#index'

  resources :properties, only:[:show, :new, :create] do
    resources :proposals, only: [:new, :create]
    resources :price_ranges, only: [:new, :create]
    get 'filtered', on: :collection
  end

  resources :proposals, only: [:show]
  resources :price_ranges, only: [:show]

end
