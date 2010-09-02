class Crew < ActiveRecord::Base
  has_one :user, :through => :creator
end
