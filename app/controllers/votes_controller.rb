class VotesController < ApplicationController
  
  before_filter :set_user, :only =>:create
  inherit_resources
  belongs_to :proposal
  actions :show, :create, :new, :index
  
  
  private
  def set_user
    params[:vote][:voter_id] = current_user.id
  end
  
end
