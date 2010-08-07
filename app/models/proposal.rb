class Proposal < ActiveRecord::Base
  
  attr_accessible :user_id, :text, :opening_at, :closing_at
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
  
  attr_accessor :user_id
  
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
  
  
  def self.votables
    all(:conditions => ["status = ? AND expiring_at > ? AND opening_at < ?",'open',Time.now.to_i, Time.now.to_i])
  end 
  
  def self.cancels
    all(:conditions => ["status = ?",'cancelled'])
  end
  
  
  def self.withdraws
    all(:conditions => ["status = ?", 'withdrawn'])
  end
  
end
