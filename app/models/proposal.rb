class Proposal < ActiveRecord::Base
  
  attr_accessible :user_id, :text, :opening_at, :closing_at
  
  validates_inclusion_of :status, :in => %w(open withdrawn cancelled)
  validate :closing_cannot_be_before_opening
  validate :closing_in_the_futur
  validates_presence_of :user_id, :text
  validates_length_of :text, :minimum=>20  
  
  belongs_to :user 
  has_many :signatures
  has_many :votes 
  
  attr_accessor :user_id
  
  
   def closing_cannot_be_before_opening
    errors.add :opening_at,'closing cannot be before opening' if opening_at >= closing_at
  end
  def closing_in_the_futur
    errors.add :closing_at,'closing must happen in the future' unless closing_at.future?
  end
  
end
