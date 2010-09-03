class Crew < ActiveRecord::Base
  has_one :user, :through => :creator
  has_many :proposals
  has_many :memberships
end
