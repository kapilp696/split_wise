Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :users do
    resources :groups
  end

  resources :groups do
    resources :group_memberships, only: :destroy
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
