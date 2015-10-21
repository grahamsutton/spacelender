Rails.application.routes.draw do

  root 'users#index'

  resources :users do
    resources :messages, :only => [:create, :destroy]

    member do
      get :confirm_email
      get :awaiting_activation
    end
  end

  resources :cards

  resources :messages, :except => [:create, :destroy]
  post 'messages/reply' => 'messages#reply'
  resources :pictures, :only => [:create, :destroy]

  get 'users/search'

  get '/registration' => 'users#new', :as => :registration
  get '/login' => 'sessions#new', :as => :login
  post 'sessions/create'
  get '/logout' => 'sessions#destroy', :as => :logout
  
  get 'listings/search' => 'listings#search'
  get 'listings/findnearme'
  get 'listings/filter_search' => 'listings#filter_search'
  post 'listings/:id/deactivating' => 'listings#deactivate', :as => :deactivate_listing
  post 'listings/:id/reactivating' => 'listings#reactivate', :as => :reactivate_listing
  get 'users/stripe_prompt' => 'users#stripe_prompt', :as => :stripe_prompt
  get 'users/change_password', :as => :change_password
  get '/dashboard' => 'listings#dashboard', :as => :dashboard
  get 'listings/index' => 'listings#index'
  get '/reservations' => 'reservations#index', :as => :reservations
  post 'reservations/:id/accept' => 'reservations#accept_reservation', :as => :accept_reservation
  post 'reservations/:id/reject' => 'reservations#reject_reservation', :as => :reject_reservation
  post 'listings/update_stripe_account' => 'listings/update_stripe_account', :as => :update_stripe_account
  get 'listings/account_updated' => 'listings/account_updated', :as => :stripe_success
  get 'listings/show'

  resources :listings, shallow: true do
    resources :reservations
  end

  resources :invoices, :except => [:new] do
    resources :refunds
  end
  get 'invoices/:token/new' => 'invoices#new', :as => :new_invoice

  resources :transactions

  # Handles stripe callback
  get '/auth/stripe_connect/callback' => 'omniauth_callbacks#stripe_connect'

  resources :favorited_listings, :only => [:create, :destroy]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
