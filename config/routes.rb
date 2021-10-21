Rails.application.routes.draw do
  resources :group_payers
  resources :group_expenses 
  resources :groups do      ##  use these user resources for invitation
    resources :group_users, path: :users, module: :groups    #   for the management of users
  end

  # scope :api, defaults: { format: :json } do
  #   devise_for :users, controllers: { sessions: :sessions },
  #                      path_names: { sign_in: :login }
  #   resource :user, only: [:show, :update]
  # end

  devise_for :users, path: '', path_names: { sign_in: "login", sign_up: "register", invitation: 'invite' }
  resources :wallets, :only => [:new, :create, :edit]
  resources :transactions, :only => [:index, :new, :create, :destroy]
  resources :income, controller: "transactions", type: "income"
  resources :expense, controller: "transactions", type: "expense"
  resources :bank_transfer, controller: "transactions", type: "bank_transfer"
  resources :bank_accounts

#   namespace :api do
#   namespace :v1 do
#     resources :transactions, only: [:index]
#   end
# end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "transaction" => "public#transaction", as: :transfer
  root to: "public#dashboard"

  # get '*path'=> redirect('/404')
end
