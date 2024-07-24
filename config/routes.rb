Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :groups
  end
  root to: "home#index"

  resources :groups do
    resources :expenses, only: [:new, :create, :index]
  end

  resources :expenses, except: [:new, :create, :index]

  resources :users, only: [:show]

  resources :debts, only: [] do
    member do
      patch :settle
    end
  end

  post 'send_invite', to: 'users#send_invite'

  # root to: "groups#index"


end
