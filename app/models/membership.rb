class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :crew
  validates_presence_of :user, :crew
  validates_inclusion_of :role, :in => %w(crewman officer root disabled), :message => "{{value}} is not a valid role"
  validate :not_last_admin?
  
  def not_last_admin?
     errors.add_to_base 'Cannot disable or revoke the last officer of the crew, invit a new officer first' if Membership.crew_id_equals(crew_id).role_equals('officer').count == 1 && %w(disabled crewman).include?(role)
  end
end
