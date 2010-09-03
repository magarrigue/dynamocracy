class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :crew
  validates_presence_of :user, :crew
  validates_inclusion_of :role, :in => %w(crewman officer root), :message => "{{value}} is not a valid role"
end
