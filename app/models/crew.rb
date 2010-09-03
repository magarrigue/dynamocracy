class Crew < ActiveRecord::Base
  has_one :user, :through => :creator
  has_many :proposals
  has_many :memberships
  validates_presence_of :name, :creator_id
  validates_uniqueness_of :creator_id, :message => 'You can only create one Crew, and you already did'
  after_create :add_officer_membership
  
  def add_officer_membership
    membership = self.memberships.create(:user_id => self.creator_id, :role => 'officer')
    membership.save!
  end
end
