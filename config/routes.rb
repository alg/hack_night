HackNight::Application.routes.draw do
  get "dashboard/show"

  root :to => 'dashboard#show'

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'
  devise_for :users

  resources :authentications, :only => :create
  resources :projects
  resources :messages, :only => [:create, :index]
end
