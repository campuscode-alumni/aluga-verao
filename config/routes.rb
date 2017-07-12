Rails.application.routes.draw do

  root to: 'home#index'
  resources :properties, only:[:show, :new, :create, :index] do
    resources :proposals, only: [:new, :create]
    resources :price_ranges, only: [:new, :create, :index]
    get 'filtered', on: :collection
  end

  resources :proposals, only:[:index, :show] do
    post 'accept', to: 'proposals#accept_proposal'
  end
  resources :price_ranges, only: [:show, :edit, :update]

  resources :properties, only:[:new, :create, :show] do
    get 'filtered', on: :collection
    resources :proposals, only: [:create, :new]
  end
end
