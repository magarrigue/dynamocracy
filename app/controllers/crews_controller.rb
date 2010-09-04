class CrewsController < ApplicationController
 


  before_filter :set_user, :only =>:create
  #after_filter :redirect_to_proposal, :only => :create
  load_and_authorize_resource
  inherit_resources
  
  private
  def set_user   
    params[:crew][:creator_id] = current_user.id
    puts params.inspect
  end
  
end
