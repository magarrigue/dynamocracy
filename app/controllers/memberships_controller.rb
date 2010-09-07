class MembershipsController < ApplicationController
  #before_filter :set_user, :only =>:create
  #after_filter :redirect_to_proposal, :only => :create

  load_and_authorize_resource :crew
  load_and_authorize_resource :membership, :through => :crew
  
  inherit_resources
  belongs_to :crew
  actions :update, :show, :index
  before_filter :only_disable_and_crewman, :only=>:update
  
  private
  def only_disable_and_crewman
    redirect_to root_url unless %w(crewman disabled).include? params[:membership][:role]
  end
  
  
end
