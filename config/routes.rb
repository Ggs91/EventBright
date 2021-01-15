Rails.application.routes.draw do

  root 'events#index'
  devise_for :users

  resources :users, only: [:show, :edit, :update] do 
    resource :avatar, only: [:create, :destroy]
  end

  resources :events do 
    resources :images, only: [:create, :destroy]
    resources :comments, only: [:create], module: :events
  end
  
  resources :comments do 
    resources :comments, only: [:create], module: :comments
  end

  resources :participations, only: [:index, :new, :create, :destroy]

  namespace :admin do
    root to: "users#index"
    resources :users
    resources :events
    resources :comments
    resources :participations, except: [:index]
  end

  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'thanks', to: 'participations#thanks', as: 'thanks'
end