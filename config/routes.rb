require 'API_app.rb'

Cubbyhole::Application.routes.draw do

  match '/api' => APIApp, :anchor => false
  
  devise_for :users, :controllers => {:registrations => 'registrations'} # skip registrations/sessions?
  devise_scope :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/signup' => 'registrations#new', :as => :new_user_registration
    get '/signup' => 'registrations#create', :as => :user_registration
    get '/settings' => 'registrations#edit', :as => :edit_user_registration
    put '/settings' => 'registrations#update', :as => :user_registration
  end

  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  
  root :to => "cubbyhole#index"

end
