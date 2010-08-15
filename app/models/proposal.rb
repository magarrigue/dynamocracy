class Proposal < ActiveRecord::Base
  
  attr_accessible :user_id, :text, :opening_at, :closing_at, :yes_count, :no_count, :support_count, :pass_count
  def after_initialize 
    set_default_opening_and_closing
  end
  
  validates_inclusion_of :status, :in => %w(open withdrawn cancelled)
  validate :closing_cannot_be_before_opening
  validate :closing_in_the_futur
  validates_presence_of :user_id, :text
  validates_length_of :text, :minimum=>20  
  
  belongs_to :user 
  has_many :signatures 
  has_many :votes 

  
  def set_default_opening_and_closing
    self.opening_at = Time.now if self.opening_at == nil
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
  
end
