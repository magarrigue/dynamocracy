class InvitationsController < ApplicationController
  
  before_filter :set_membership_user, :only=> :create
  
  load_and_authorize_resource :crew
  load_and_authorize_resource :invitation, :through => :crew
 
  inherit_resources
  nested_belongs_to :crew, :membership
  
  
  private
  def set_membership
    params[:invitation][:membership_id] = Membership.user_equals(current_user).crew_id_equals(params[:crew_id]).first
  end
end
