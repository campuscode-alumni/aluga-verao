Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'
  get 'my_proposals', to: 'proposals#my_proposals'

  root to: 'home#index'
  resources :properties, only:[:show, :new, :create, :index, :edit, :update] do
    resources :proposals, only: [:new, :create]
    resources :price_ranges, only: [:new, :create, :index]
    get 'filtered', on: :collection
    resources :reviews, only: [:new, :create, :show]
  end

  resources :proposals, only:[:index, :show] do
    post 'accept', to: 'proposals#accept_proposal'
    get 'print', to: 'proposals#print_cupom'
  end

  resources :price_ranges, only: [:show, :edit, :update]

  resources :property_types, only: [:show, :new, :create]

  resources :rents, only: [:show]
  get 'my_rents', to: 'rents#my_rents'
end
