class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :crew
  validates_presence_of :user, :crew
  validates_inclusion_of :role, :in => %w(crewman officer root disabled), :message => "{{value}} is not a valid role"
  validate :not_last_officer?
  
  def new_record?
    id.nil?
  end  
  
  def not_last_officer?
     if %w(disabled crewman).include?(role)  && 
      Membership.crew_id_equals(crew_id).role_equals('officer').count == 1 &&
      Membership.crew_id_equals(crew_id).role_equals('officer').first.id == id
       errors.add_to_base 'Cannot disable or revoke the last officer of the crew, invit a new officer first' 
     end
  end
end
