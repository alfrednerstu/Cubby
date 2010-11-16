class User < ActiveRecord::Base
  
  has_many :authentications
  
  validates_presence_of :username

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
  
  def apply_omniauth(omniauth)
    self.username = omniauth['user_info']['nickname'] if username.blank?
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  attr_accessible :username, :email, :password, :remember_me

end