class User < ActiveRecord::Base
  
  has_many :authentications

  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["username = :value OR email = :value", { :value => value }]).first
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

end