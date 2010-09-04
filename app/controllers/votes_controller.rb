class VotesController < ApplicationController
  before_filter :set_user, :only =>:create
  load_and_authorize_resource
  inherit_resources
  nested_belongs_to :crew, :proposal
  actions :create, :new, :show
  
 
  private
  def set_user
    params[:vote][:voter_id] = current_user.id
  end
  
  
end
