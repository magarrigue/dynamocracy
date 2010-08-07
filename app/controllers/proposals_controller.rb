class ProposalsController < ApplicationController
  
  before_filter :set_user, :only => :create
  
  
  inherit_resources
  
  

  private
  def set_user
    params[:proposal][:user_id] = current_user.id
  end
  
end
