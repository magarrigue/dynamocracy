class ProposalsController < ApplicationController
  
  before_filter :set_user, :only => :create

  
  inherit_resources
  belongs_to :crew
  
  def index
     search nil
  end 
  
  def ongoing
    search(:opening_at_before => Time.now, :closing_at_after => Time.now, :status_equals => 'open')
  end
  
  def decision
    search(:closing_at_before => Time.now, :status_equals => 'open')
  end

  def pending
    search(:opening_at_after => Time.now, :status_equals => 'open' )
  end
  
  def withdrawn
    search(:status_equals => 'withdrawn')
  end

  def cancelled
    search(:status_equals => 'cancelled')
  end
  
  def my
    search(:user_id => current_user.id)
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
  
  def search(conditions)
    @search = Proposal.search(conditions)
    @proposals = @search.paginate(:page=>params[:page], :per_page=>5, :include => [:user, :votes, :cancelled_by])
    @my_signatures = Signature.user_id_eq(current_user.id).proposal_id_in(@proposals).all 
    render "index"
  end
  
end
