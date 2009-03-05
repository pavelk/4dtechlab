ActionController::Routing::Routes.draw do |map|
  map.resources :items, :has_many => :comments

  map.resources :questions, :member => { :solved => :put }
  map.answered "/answered", :controller => 'questions', :action => "answered"
 
  map.resources :helps, :as => 'help', :has_many => :comments
  
  map.resources :libraries do |library|
    library.resources :items, :member => { :add_photo => :put, :add_file => :put }
  end


  #map.root :controller => "home"
  #map.home '/', :controller => 'home', :action => 'index', :method => :get
  map.root :controller => "home"
  map.home '/', :controller => 'home'
  
  #map.resources :posts

  map.resources :forums do |forum| 
    forum.resources :topics do |topic| 
      topic.resources :posts
    end 
  end 
  

  map.resources :comments

  #map.connect 'events/:year/:month/:day/:id', :controller => 'events',
  #    :month => nil, :day => nil, :requirements => { :year => /\d{4}/ }
  map.resources :events, :has_many => :comments, :member => { :add_photo => :put, :add_file => :put, :remove_photo => :delete }

  map.events_all 'events/:year/:month', :controller => 'events', :action => 'index',
                  :month => nil, :requirements => { :year => /\d{4}/ }
  
#  map.events_detail 'events/:id/:year/:month/:day/:title', :controller => 'events', :action => 'show', :title => nil,
#                  :requirements => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ }
                  
  map.events_detail 'events/:year/:month/:day/:id', :controller => 'events', :action => 'show',
                  :requirements => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ }

  map.search '/search', :controller => 'search', :action => 'index', :method => :get      

  map.resource :user_session
  map.resources :users, :as => 'people', :member => { :change_password => :get, :registration => :get, :approved => :put }, :collection => { :recent => :get, :noapproved => :get }
  #map.new_registered "/new_registered", :controller => 'users', :action => "index"
  map.user_detail 'person/:id/:user', :controller => 'users', :action => 'show', :user => nil
  #map.registration 'users/registration', :controller => 'users', :action => 'registration'
  #map.resource :account, :controller => "users", :member => { :change_password => :get, :user_detail => :get }
  #map.resource :account, :controller => "users", :action => 'new'
  #map.user_detail 'users/:id/:title', :controller => 'users', :action => 'user_detail', :title => nil
  map.resources :password_resets
  #map.root :controller => "user_sessions", :action => "new"
  map.connect "logged_exceptions/:action/:id", :controller => "logged_exceptions"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
