Rails.application.routes.draw do
  root to: 'home#index'

  resources :proposals, only:[:index, :show] do
    post 'accept', to: 'proposals#accept_proposal'
  end

  resources :properties, only:[:new, :create, :show] do
    get 'filtered', on: :collection
    resources :proposals, only: [:create, :new]
  end
end
