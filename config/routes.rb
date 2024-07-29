Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  resources :users do
    resources :groups
  end

  resources :groups do
    member do
      get 'manage_members'
      post 'add_members'
      delete 'remove_member/:user_id', to: "groups#remove_member", as: :remove_member
    end
    resources :expenses
  end

  resources :expenses, except: [:new, :create, :index]

  resources :debts, only: [] do
    member do
      get :settle
    end
  end

  post 'send_invite', to: 'users#send_invite'

end
