HackNight::Application.routes.draw do
  get "dashboard/show", :as => 'dashboard'

  root :to => 'dashboard#show'

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'
  devise_for :users

  resources :authentications, :only => :create
  resources :projects do
    member do
      get :join
      get :leave
    end
    
    resources :links, :only => :create
  end
  resources :messages, :only => [ :create, :index ]

  post "willgo" => "attendances#willgo"
  post "wontgo" => "attendances#wontgo"
end
