require 'api/api.rb'

Cubbyhole::Application.routes.draw do

  resources :users

  resources :games
  resources :articles

  #match '/api' => ApiApp
	#match '/api/:more' => ApiApp
  
  devise_for :users, :controllers => {:registrations => 'registrations'} # skip registrations/sessions?
  devise_scope :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/signup' => 'registrations#new', :as => :new_user_registration
    #get '/signup' => 'registrations#create', :as => :user_registration
    get '/settings' => 'registrations#edit', :as => :edit_user_registration
    put '/settings' => 'registrations#update', :as => :edit_user_registration
  end

  resources :authentications
	resources :api
  match '/auth/:provider/callback' => 'authentications#create'
  
  root :to => "cubbyhole#index"

end
