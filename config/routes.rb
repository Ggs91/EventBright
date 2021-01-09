Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update] do 
    resource :avatar, only: [:create, :destroy]
  end
  resources :events do 
    resource :images, only: [:create, :destroy]
  end
  resources :participations, only: [:index, :new, :create, :destroy]
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'thanks', to: 'participations#thanks', as: 'thanks'
end