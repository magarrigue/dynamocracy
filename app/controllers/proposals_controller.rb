class ProposalsController < ApplicationController
 
  
  
  before_filter :set_user, :only => :create
  before_filter :get_crew
  load_and_authorize_resource

  inherit_resources
  belongs_to :crew
  
  
  def index
   
    conditions = params[:search]||{}
    conditions['my'] = current_user.id.to_i if(conditions.has_key?('my'))
    conditions = conditions.delete_if{|k,v| !%w(ongoing decision pending cancelled withdrawn order my).include? k}
    conditions = {:crew_id_equals => params[:crew_id]}.merge(conditions)     
   
    @search = Proposal.search(conditions)
    @proposals = @search.paginate(:page=>params[:page], :per_page=>5, :include => [:user, :votes, :cancelled_by])
    @my_signatures = Signature.user_id_eq(current_user.id).proposal_id_in(@proposals).all 
    render "index"
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
    redirect_to crew_proposal_path(@proposal.crew, @proposal)
  end
  
  private
  def set_user
    params[:proposal][:user_id] = current_user.id
  end
  def get_crew
    @crew = Crew.find(params[:crew_id])
  end
  
  def search(conditions)
    conditions = {:crew_id_equals => params[:crew_id]}.merge(conditions)
    puts conditions
    @search = Proposal.search(conditions)
    @proposals = @search.paginate(:page=>params[:page], :per_page=>5, :include => [:user, :votes, :cancelled_by])
    @my_signatures = Signature.user_id_eq(current_user.id).proposal_id_in(@proposals).all 
    render "index"
  end
  
  
  def my
    search(:user_id => current_user.id)
  end
  
end
