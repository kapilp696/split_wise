Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: "home#index"

  resources :groups do
    resources :expenses
  end

  resources :users, only: [:show]

  resources :debts, only: [] do
    member do
      patch :settle
    end
  end

  # root to: "groups#index"


end
