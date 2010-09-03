class ProposalsController < ApplicationController
  
  before_filter :set_user, :only => :create

  
  inherit_resources
  belongs_to :crew
  
  def index
     @search = Proposal.search(params[:search])
     @proposals = @search.paginate(:page=>params[:page], :per_page=>5, :include => [:user, :votes, :cancelled_by])
     @my_signatures = Signature.user_id_eq(current_user.id).proposal_id_in(@proposals).all
    
  end 

  def withdraw
    @proposal = Proposal.find(params[:id])
    if current_user.id == @proposal.user_id && @proposal.status=='open' && @proposal.closing_at > Time.now
      @proposal.status='withdrawn' 
      @proposal.save
      flash[:notice]='Proposal succesfully withdrawn'
    else
      flash[:error]='Can\'t withdrawn a proposal that is not yours, closed, cancelled, or already withdrawn'
    end
    redirect_to :action => "index"
  end
  
  private
  def set_user
    params[:proposal][:user_id] = current_user.id
  end
  
end
