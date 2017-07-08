Rails.application.routes.draw do
  root to: 'home#index'
  resources :properties, only:[:new, :create, :show] do
    get 'filtered', on: :collection
  end
end
