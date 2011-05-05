HackNight::Application.routes.draw do
  get "dashboard/show"

  root :to => 'dashboard#show'

  match '/auth/twitter' => 'authentications#index', :as => 'auth'
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users

  resources :authentications, :only => :create
end
