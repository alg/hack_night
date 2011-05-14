HackNight::Application.routes.draw do
  get "dashboard/show", :as => 'dashboard'

  root :to => 'dashboard#show'

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'
  devise_for :users

  resources :authentications, :only => :create
  resources :projects
  resources :messages, :only => [:create, :index]

  post "willgo" => "attendances#willgo"
  post "wontgo" => "attendances#wontgo"
end
