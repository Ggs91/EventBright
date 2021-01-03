Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :events
  resources :participations, only: [:index, :new, :create, :destroy]
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'thanks', to: 'participations#thanks', as: 'thanks'
end
