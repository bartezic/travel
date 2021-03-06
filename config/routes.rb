Travel::Application.routes.draw do
  

  resources :request_actions, :only => [:create]
  resources :tours, :only => [:index, :show]
  # resources :hotels, :only => [:index, :show]
  resources :continents, :only => [:index, :show]
  resources :regions, :only => [:index, :show]
  resources :attractions, :only => [:index, :show]
  resources :countries, :only => [:index, :show] do
    resources :regions, :only => [:index, :show] do
      resources :attractions, :only => [:show]
      resources :hotels, :only => [:show]
    end
  end

  resources :api, except: :all do
    get :geocode,    on: :collection
    get :panoramio,  on: :collection
    get :photos,     on: :collection
    get :tags,       on: :collection
    get :regions,    on: :collection
    get :galleries,  on: :collection
  end

  match 'hot_tours' => 'static#hot_tours'
  match 'partners' => 'static#partners'
  match 'contacts' => 'static#contacts'
  match 'visas' => 'static#visas'
  match 'home' => 'static#home'
  root :to => 'static#home'
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

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
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match '*a' => 'static#error'
end
