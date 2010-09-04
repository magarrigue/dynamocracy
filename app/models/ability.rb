class Ability
  include CanCan::Ability
  
  
  def initialize(user)
    puts user.inspect
    puts user.memberships.inspect
    user.memberships.each do |membership|
      if(membership.role=='root')
        can :manage, :all
      end
      if(membership.role=='officer')
        can :manage, Membership, :crew_id => membership.crew_id 
        can :update, Crew, :id => membership.crew_id
      end
      if(%w(officer crewman).include? membership.role)
        can :create, Proposal#, :crew_id => membership.crew_id, :user_id => user.id
        can :create, Vote#, :crew_id => membership.crew_id
        can :read,  Membership, :id => membership.crew_id
        can :read,  Crew, :id => membership.crew_id
        can :read,  Proposal, :crew_id => membership.crew_id
        can :update, Proposal, :crew_id => membership.crew_id, :user_id=>user.id
        can :destroy, Proposal, :crew_id => membership.crew_id, :user_id=>user.id
        can :read, Vote, :crew_id => membership.crew_id, :proposal=>{:user_id=>user.id}
      end
       
    end
    can :create,  Crew
    
  end
    
end
