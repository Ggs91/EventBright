Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update] do 
    resource :avatar, only: [:create, :destroy]
  end
  resources :events do 
    resources :images, only: [:create, :destroy]
    resources :comments, except: [:index, :show, :new]
  end
  resources :participations, only: [:index, :new, :create, :destroy]

  # resources :comments do
  #   resources :comments
  # end
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'thanks', to: 'participations#thanks', as: 'thanks'
end