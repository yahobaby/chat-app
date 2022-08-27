Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
  resources :users, only: [:edit, :update]
#ユーザー編集に必要なルーティングは、editとupdateなので、
# routes.rbに、 resources :users, only: [:edit, :update]と追記
end