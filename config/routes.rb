HackNight::Application.routes.draw do

  root  :to => 'dashboard#show'
  post  '/update_status' => 'dashboard#update_status', :as => 'update_status'
  
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
  resources :events

  post "willgo" => "attendances#willgo"
  post "wontgo" => "attendances#wontgo"

  mount AssetServer.instance => 'javascripts'
  mount AssetServer.instance => 'stylesheets'
end
