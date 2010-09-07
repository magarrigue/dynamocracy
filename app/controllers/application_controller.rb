# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!, :except=>:index
  before_filter :check_invitation
  
  # Preserve privacy even from admin-sys when voting
  filter_parameter_logging :value
  layout "main"
  
  rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = exception.message
      puts exception.inspect
      redirect_to root_url
  end
  
  def index
    @has_crew = Crew.creator_id_equals(current_user.id).count==1 if user_signed_in?
    fetch_news
  end
  
  private
  def check_invitation 
    if user_signed_in? && !pending_invitation.nil?
       if current_user.email == pending_invitation.email && pending_invitation.pending?
        puts 'should proceed now'
        proceed_to_invitation pending_invitation
       end
       session[:pending_invitation] = nil
    end
  end
  
  def pending_invitation
    session[:pending_invitation]
  end
  
  def proceed_to_invitation(invitation)
     membership = Membership.crew_id_equals(invitation.crew_id).user_id_equals(current_user.id).first
     if(membership.nil?)
      membership = Membership.new(:user_id=>current_user.id, :crew_id=>invitation.crew_id)
     end
     membership.role = invitation.role
     membership.save!
     invitation.validated_at = Time.now
     invitation.save!
  end
  
  
  
 def fetch_news(since=1.week.ago)

    if user_signed_in?
      @new_unvoteds = Proposal.accessible(current_user.id).ongoing.signatures_user_id_does_not_equal_all(current_user.id).updated_at_after(since)+
      Proposal.accessible(current_user.id).ongoing.signatures_count_equals(0).updated_at_after(since)
      @new_decisions = Proposal.accessible(current_user.id).decision.updated_at_after(since)
      @new_members = Membership.accessible(current_user.id).updated_at_after(since)
      @new_votes = Proposal.accessible(current_user.id).user_id_equals(current_user.id).votes_created_at_after(since)
    end
 end 
end
