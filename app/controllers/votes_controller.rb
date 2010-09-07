class VotesController < ApplicationController
  before_filter :set_user, :only =>:create
  
  load_and_authorize_resource :crew#, :parent=>false
  load_and_authorize_resource :proposal, :through=>:crew
  authorize_resource :vote, :through =>:proposal 
  
  inherit_resources
  nested_belongs_to :crew, :proposal
  
  actions :create, :new
  
  
  def create
    create!(:notice => "You voted for this proposal") do |success, failure|
        success.html{
         
          redirect_to crew_proposal_url(@vote.proposal.crew,@vote.proposal)          
          }
        failure.html
    end

  end
  
 
  private
  def set_user
    params[:vote][:voter_id] = current_user.id
  end
  
  
end
