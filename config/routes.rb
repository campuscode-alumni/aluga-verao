Rails.application.routes.draw do
  root to: 'home#index'

  resources :proposals, only:[:index, :show] do
    post 'accept', to: 'proposals#accept_proposal'
  end
  resources :properties, only:[:new, :create, :show] do
    resources :proposals, only: [:create, :new]
    get 'filtered', on: :collection
  end
end
