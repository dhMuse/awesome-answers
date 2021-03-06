AwesomeAnswers::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
# route order matters; searching matches top to bottom, and stops when it finds a match.

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # http verb "path or url" => "controller#action"
  get "/about_us" => "home#about"
  get "/faq" => "home#faq"
  get "/help" => "help#index"

  # get   "/questions"          => "questions#index"
  # post  "/questions"          => "questions#create"
  # get   "/questions/:id"      => "questions#show"
  # get   "/questions/:id/edit" => "questions#edit"
  # get   "/questions/new"      => "questions#new"
  # match "/questions/:id"      => "questions#update", via: [:patch, :put]
  # delete "questions/:id"      => "questions#destroy"
  # all the above commented code can be written as the following

  resources :answers, only: [:index]

  resources :questions do #you can also specify with ", only: [:index, :update]" or ", except: [:index]"
    resources :favourites, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
    resources :answers, except: [:index]
    # or 
    # member do
    #   post :vote_up
    #   post :vote_down
    # end
    post :search, on: :collection
  end

  # Don't triple nest routes. To subordinate comments to answers, where answers is nested in qustions, use the following structure:
  resources :answers, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  root "questions#index"

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
