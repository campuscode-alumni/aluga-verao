Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'my_proposals', to: 'proposals#my_proposals'
  resources :proposals, only:[:index, :show] do
    post 'accept', to: 'proposals#accept_proposal'
    get 'print', to: 'proposals#print_cupom'
  end

  resources :properties, only:[:new, :create, :show] do
    get 'filtered', on: :collection
    resources :proposals, only: [:create, :new]
  end
end
