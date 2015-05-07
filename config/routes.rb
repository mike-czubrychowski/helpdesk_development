Rails.application.routes.draw do
  
  

  
  devise_for :users
  
  namespace :store do
    resources :details
    resources :tills
  end


  resources :locations
  
    resources :worlds, controller: 'locations', type: 'World' 
    resources :globalregions, controller: 'locations', type: 'Globalregion' 
    resources :country, controller: 'locations', type: 'Country'
    #add in this because routes is not properly pluralizing country
    get :countries, controller: 'locations', action: 'index', type: 'Country'  
    resources :divisions, controller: 'locations', type: 'Division' 
    resources :regions, controller: 'locations', type: 'Region' 
    resources :areas, controller: 'locations', type: 'Area' 
    resources :sites, controller: 'locations', type: 'Site' 
    resources :storelocations, controller: 'locations', type: 'Storelocation' 
    


  

  namespace :ticket do
    resources :details
    resources :comments
    resources :user_assignments
    resources :statuses
    resources :status_histories
    resources :categories
    resources :subcategories
    resources :statistics
  end

  
  resources :organisations
  resources :roles
  resources :assignments
  resources :people

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'ticket/details#index'

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
