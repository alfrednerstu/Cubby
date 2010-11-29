class ApiApp < Sinatra::Base
	set :root, File.dirname(__FILE__)
	#register Sinatra::Warden
	
	require 'rubygems'
	require 'sinatra'
	require 'sequel'
	require 'sinatra/sequel'
	
	configure do
		Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://development.sqlite3')
	end
	
	class User < Sequel::Model
		plugin :schema
		unless table_exists?
			set_schema do
				primary_key :id
				string   :email,                               :default => "", :null => false
		    string   :encrypted_password,   :limit => 128, :default => "", :null => false
		    string   :password_salt,                       :default => "", :null => false
		    string   :reset_password_token
		    string   :remember_token
		    datetime :remember_created_at
		    integer  :sign_in_count,                       :default => 0
		    datetime :current_sign_in_at
		    datetime :last_sign_in_at
		    string   :current_sign_in_ip
		    string   :last_sign_in_ip
		    datetime :created_at
		    datetime :updated_at
		    string   :username
			end
			create_table
		end
	end
		
  get "/api" do
		env["warden"].inspect
		#puts env["warden"].warden.user.user.key

  end

	get "/api/test" do
		ENV['DATABASE_URL'].inspect
		User.inspect
		#haml :test
	end

	get '/api/admin' do
		authorize! # require session, redirect to '/login' instead of work
		haml :admin
	end

	get '/api/dashboard' do
		authorize! # require a session for this action
		haml :dashboard
	end
end

# @user = env["warden"]
# erb :api, :locals => @user
