Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :groups
  end
  root to: "home#index"

  resources :groups do
    member do
      get 'manage_members'
      post 'add_members'
      delete 'remove_member/:user_id', to: "groups#remove_member", as: :remove_member
      # delete 'remove_member'
    end
    resources :expenses, only: [:new, :create, :index, :show]
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
