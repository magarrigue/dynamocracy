# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  include News
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!, :except=>:index
  before_filter :check_invitation#, :unless=>:signed?
  
  # Preserve privacy even from admin-sys when voting
  filter_parameter_logging :value
  layout "main"
  
  rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = exception.message
      logger.warn exception.inspect
      redirect_to root_url
  end
  
  def index
    if user_signed_in?
      @my_crew = Crew.creator_id_equals(current_user.id).first
      fetch_news_for_user(current_user)
      @crews_count = Membership.user_id_equals(current_user).role_does_not_equal('disabled').count
    end
  end
  
  private
#  def signed?
#  
#    self.controller_name=='sessions'
#  end
#  
  
  def check_invitation 
    if user_signed_in? && !pending_invitation.nil?
       if current_user.email == pending_invitation.email && pending_invitation.pending?
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
  
  
end
