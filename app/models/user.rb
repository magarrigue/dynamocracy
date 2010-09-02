class User < ActiveRecord::Base

  
  devise :database_authenticatable, :registerable,  
         :confirmable, :recoverable, 
         :rememberable, :trackable, :validatable
         
  attr_accessible :email, :password, :password_confirmation       
  
  def nickname
    email.split('@')[0]
  end
end
