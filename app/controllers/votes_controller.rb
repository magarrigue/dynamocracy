class VotesController < ApplicationController
  
  before_filter :set_user, :only =>:create
  #after_filter :redirect_to_proposal, :only => :create
  inherit_resources
  belongs_to :proposal
  belongs_to :crew
  actions :create, :new, :show
  
 
  private
  def set_user
    params[:vote][:voter_id] = current_user.id
  end
  
  
end
