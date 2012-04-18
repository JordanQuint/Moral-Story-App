MoralStory::Application.routes.draw do
  devise_for :users

  match "story/follow", :to => "Story#follow"
  match "story/like", :to => "Story#like"
  match "users/follow", :to => "Users#follow"
  
  devise_scope :user do
    match "users/sign_out", :to => "Devise/sessions#destroy"
  end

  resources :pages
  resources :users
  resources :story
  
  match "/search", :to => "Pages#search"
  
  get "users/show"
  
  get "comment/show"
  match "story/comment", :to => "Story#comment"

  get "story/index"
  match "/stories", :to => "Story#index"
  get "story/show"
  get "story/create"
  get "story/new"
  get "story/destroy"
  get "story/upvote"
  get "story/downvote"
  match "/notifications", :to => "Pages#notifications"
  
  # Sets the host for Devise
  default_url_options :host => "localhost:3000"

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
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"
end
