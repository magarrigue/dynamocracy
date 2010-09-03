class CrewsController < ApplicationController
 
  load_and_authorize_resource

  #before_filter :set_user, :only =>:create
  #after_filter :redirect_to_proposal, :only => :create
  inherit_resources
  
  #actions :create, :new, :show
  
end
