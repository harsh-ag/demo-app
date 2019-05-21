Rails.application.routes.draw do
  root to: 'application#home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :secret_codes, only: [:create, :index]
end
