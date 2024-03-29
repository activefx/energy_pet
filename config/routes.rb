EnergyPet::Application.routes.draw do

  devise_for :users, :controllers => { :confirmations => "users/confirmations",
                                       :omniauth_callbacks => "users/omniauth_callbacks",
                                       :passwords => "users/passwords",
                                       :registrations => "users/registrations",
                                       :sessions => "users/sessions",
                                       :unlocks => "users/unlocks" }

  devise_for :administrators

  namespace :users do
    resources :authentications
  end

  namespace :admin do
    resources :dashboard, :as => 'dashboard'
    resources :beta_signups
    resources :administrators
    resources :users
  end

  #match '/auth/:provider/callback' => 'authentications#create'
  #devise_for :users, controllers: {registrations: 'registrations'}

  resources :devices
  resources :settings
  resources :introductions
  resources :meter_readings
  resources :costs
  resources :projected_costs
  resources :neighbors
  resources :bad_simulations
  resources :good_simulations
  resources :simulations
  resources :thermostats

  match '/user' => "introductions#index", :as => :user_root
  match 'admin/dashboard' => "admin/dashboard#index", :as => :administrator_root

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

