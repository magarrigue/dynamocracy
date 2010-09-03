class MembershipsController < ApplicationController
  #before_filter :set_user, :only =>:create
  #after_filter :redirect_to_proposal, :only => :create
  load_and_authorize_resource

  inherit_resources
  belongs_to :crew
  #actions :create, :new, :show
end
