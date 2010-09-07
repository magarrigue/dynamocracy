class Invitation < ActiveRecord::Base
  belongs_to :crew
  belongs_to :user
  
  validates_presence_of :email, :crew_id, :user_id, :type
  validates_format_of :email, :with => Devise::EMAIL_REGEX, :message => "is not a valid email"
  #validates_uniqueness_of :email, :case_sensitive => false, :scope => :crew_id, :message => "has already been invited to this crew"
 validates_inclusion_of :role, :in => %w(crewman officer), :message => "{{value}} is not a valid role"
  before_save :set_email_to_downcase
  
  
  def set_new_token
   self.invitation_token = Devise.friendly_token
   self.save!
  end
  
  def pending?
    validated_at.nil? && (expire_at.nil? || (expire_at && expire_at.before_now))
  end
  
  private
  def set_email_to_downcase
    self.email = self.email.downcase
  end
end
