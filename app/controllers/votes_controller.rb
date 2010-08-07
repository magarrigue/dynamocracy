class VotesController < ApplicationController
  
  before_filter :set_user, :only =>:create
  before_filter :show_params
  inherit_resources
  belongs_to :proposal
  actions :show, :create, :new, :index
  
  
  private
  def set_user
    puts current_user
    params[:vote][:voter_id] = current_user.id
  end
  def show_params
    puts params.inspect
  end
end
