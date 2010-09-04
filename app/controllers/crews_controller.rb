class CrewsController < ApplicationController
 


  before_filter :set_user, :only =>:create

  load_and_authorize_resource
    
  inherit_resources
  
  def index
    @crews =  Crew.accessible_by(current_ability) 
  end
  
  private
  def set_user   
    params[:crew][:creator_id] = current_user.id
  end
  
end
