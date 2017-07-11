Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :properties, only:[:show, :new, :create] do
    resources :proposals, only: [:new, :create]
    get 'filtered', on: :collection
  end

  resources :proposals, only: [:show]

end
