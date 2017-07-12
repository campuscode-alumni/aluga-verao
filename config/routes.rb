Rails.application.routes.draw do
  root to: 'home#index'

  resources :properties, only:[:show, :new, :create, :index] do
    resources :proposals, only: [:new, :create]
    resources :price_ranges, only: [:new, :create, :index]
    get 'filtered', on: :collection
  end

  resources :proposals, only: [:show]
  resources :price_ranges, only: [:show, :edit, :update]

end
