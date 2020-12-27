Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events, only: [:new, :create, :show]
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
end
