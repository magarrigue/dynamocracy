class Proposal < ActiveRecord::Base
  

  
  attr_accessible :user_id, :text, :opening_at, :closing_at, :pass_count, :crew_id, :public_comments_allowed
  def after_initialize 
    set_default_opening_and_closing
  end
  
  validates_inclusion_of :status, :in => %w(open withdrawn cancelled)
  validate :closing_cannot_be_before_opening
  validate :closing_in_the_futur
  validates_presence_of :user_id, :text#, :crew_id
  validates_length_of :text, :minimum=>20  

  belongs_to :crew  
  belongs_to :user 
  has_many :signatures 
  has_many :votes 
  belongs_to :cancelled_by, :class_name=>"User" 
  
  
  scope_procedure :ongoing,   lambda{opening_at_before(Time.zone.now).closing_at_after(Time.zone.now).status_equals('open')}
  scope_procedure :decision,  lambda{closing_at_before(Time.zone.now).status_equals('open')}
  scope_procedure :pending,   lambda{opening_at_after(Time.zone.now).status_equals('open')}
  scope_procedure :withdrawn, lambda{status_equals('withdrawn')}
  scope_procedure :cancelled, lambda{status_equals('cancelled')}
  scope_procedure :my, lambda { |user_id| user_id_equals(user_id)  }
  scope_procedure :accessible, lambda{ |user_id|  crew_memberships_user_id_equals(user_id).crew_memberships_role_does_not_equal('disabled')}
  scope_procedure :voted, lambda{ |user_id|  signatures_user_id_equals(user_id)}
  
  def set_default_opening_and_closing
    self.opening_at = Time.zone.now if self.opening_at == nil
    self.closing_at = 7.day.from_now if self.closing_at == nil
  end
  
  def closing_cannot_be_before_opening
    errors.add :opening_at,'closing cannot be before opening' if opening_at >= closing_at
  end
  def closing_in_the_futur
    errors.add :closing_at,'closing must happen in the future' unless closing_at.future?
  end


  def full_status
    return status unless status == 'open'
    return 'open' if closing_at.future? && opening_at.past?
    return 'closed' if closing_at.past?
    return 'pending' if opening_at.future?
    return 'unknown'
  end  
  
    
  def begining
    return text[0..35]+"..." if(text.length>=35)
    text
  end
  
  
  def comments(user_id)
    comments = []
    if(public_comments_allowed || self.user_id == user_id)
      comments = votes.collect{|v| v.comment}.find_all{|c| !c.empty?}
    end
    comments
  end
  
  
#  def pass_count
#    signatures_count - yes_count - no_count - support_count
#  end
end
