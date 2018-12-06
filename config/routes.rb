Rails.application.routes.draw do
  resources :stops
  resources :routes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'routes#index'
end
