class Invitation < ActiveRecord::Base
  belongs_to :crew
  belongs_to :user
  validates_presence_of :email
  validates_format_of :email, :with => Devise::EMAIL_REGEX, :message => "is not a valid email"
  
end
