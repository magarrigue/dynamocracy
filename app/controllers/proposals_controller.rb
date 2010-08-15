class ProposalsController < ApplicationController
  
  before_filter :set_user, :only => :create
  
  
  inherit_resources
  
  def index
     @search = Proposal.search(params[:search])
     @proposals = @search.paginate(:page=>params[:page], :include => [:votes,:user])
     @signatures = Signature.user_id_eq(current_user.id).proposal_id_in(@proposals).all
  end 

  private
  def set_user
    params[:proposal][:user_id] = current_user.id
  end
  
end
