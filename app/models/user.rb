class User < ActiveRecord::Base

  #has_one :crew
  has_many :memberships
  
  devise  :database_authenticatable, 
          :registerable,  
          :confirmable, 
          :recoverable, 
          :rememberable, 
          :trackable, 
          :validatable
         
  attr_accessible :email, :password, :password_confirmation, :remember_me    
  
  def nickname
    email.split('@')[0]
  end
  
  def has_membership?(role_sym)
     memberships.any? { |r| r.role.underscore.to_sym == role_sym }
  end
  
  def password_required? 
    new_record? 
  end
end
