StoreEngine::Application.routes.draw do
  root to: 'products#index'

  get "/code" => redirect("http://github.com/raphweiner/store_engine")
  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#new", :as => "signup"

  get "/checkout" => "checkout#show"

  get "/account" => redirect("/account/profile")
  get "/account/profile" => "users#show"
  get "/account/orders" => "orders#index"
  get "/account/orders/:id" => "orders#show", :as => "account_order"

  post "/buy_now" => "orders#buy_now", :as => 'buy_now'
  put "/i18n" => "i18n#update"

  resources :sessions,  only:  [ :new, :create, :destroy ]
  resources :products,  only:  [ :index, :show ]
  resources :shippings, only:  [ :create ]

  resource :cart, only: [ :update, :show, :destroy ] do
    member do
      put :remove_item
    end
  end

  resources :users, only: [ :new, :create, :update ] do
    resources :orders, except: [ :show ]
  end

  namespace :admin do
    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'

    resources :products do
      member do
        post :toggle_status
      end
    end

    resources :orders, only: [ :show, :update ]
    resources :order_items, only: [ :update, :destroy]
    resources :categories, except: [ :show ]
  end
end
