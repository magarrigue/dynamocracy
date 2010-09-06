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
  
  
#  def destroy
#    @membership = Membership.find(params[:id])
#    puts @membership.inspect
#    @membership.role = 'disabled'
#    puts @membership.inspect
#    if(@membership.save)

#      puts 'redirect'
#      redirect_to crew_memberships_path(@membership),:notice =>membership.errors.inspect
#    else
#      puts @membership.errors.inspect
#      puts @membership.inspect
#      @memberships = Membership.crew_id_equals(params[:crew_id])
#      render 'index',:notice =>@membership.errors.inspect
#    end
#  end
end
