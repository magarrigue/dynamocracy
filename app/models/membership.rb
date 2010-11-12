class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :crew
  validates_presence_of :user, :crew
  validates_inclusion_of :role, :in => %w(crewman officer root disabled), :message => "%{value} is not a valid role"
  validate :not_last_officer?


  def self.accessible_members(user_id)    
    find_by_sql( 
    "SELECT distinct memberships.* FROM memberships INNER JOIN crews ON crews.id = memberships.crew_id INNER JOIN memberships memberships_crews ON memberships_crews.crew_id = crews.id WHERE (memberships_crews.user_id = #{user_id}) AND memberships.role <>'disabled'"
    )
  end
  
  def self.accessible_members(user_id, since)  
    find_by_sql( 
    ["SELECT distinct memberships.* FROM memberships INNER JOIN crews ON crews.id = memberships.crew_id INNER JOIN memberships memberships_crews ON memberships_crews.crew_id = crews.id WHERE (memberships_crews.user_id = ?) AND memberships.role <>'disabled' AND memberships_crews.updated_at >?",user_id,since
    ])
  end
  
  #crew_memberships_user_id_equals(user_id).crew_memberships_role_does_not_equal('disabled')}
  def new_record?
    id.nil?
  end  
  
  def not_last_officer?
     if %w(disabled crewman).include?(role)  && !id.nil?
      Membership.crew_id_equals(crew_id).role_equals('officer').count == 1 &&
      Membership.crew_id_equals(crew_id).role_equals('officer').first.id == id
       errors.add_to_base 'Cannot disable or revoke the last officer of the crew, invit a new officer first' 
     end
  end
  
end
