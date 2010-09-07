class InvitationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:accept]
  before_filter :set_user, :only => :create 
  load_and_authorize_resource :crew, :except => [:accept]
  load_and_authorize_resource :invitation, :through => :crew,  :except => [:accept]
 
  inherit_resources
  belongs_to :crew
  
  def create
    create!(:notice => "an invitation email has been sent to #{@invitation.email}") do |success, failure|
        success.html{
          send_mail
          redirect_to crew_invitations_url          
          }
        failure.html
    end
  end
  
  def show
    show!
    redirect_to crew_invitations_url
 end
  
  def update
    if @invitation.pending?
      send_mail
      flash[:notice] ="a new invitation email has been sent to #{@invitation.email}"         
    else
      flash[:error] = "This invitation is no more pending"
    end
     redirect_to crew_invitations_url 
  end


  def accept
    invitation = Invitation.invitation_token_equals(params[:invitation_token]).first
    puts "Invitation with token found #{invitation.inspect}"
    
    if invitation.nil?
      flash[:error] = "This invitation is not valid"
      redirect_to root_url
    
    elsif !invitation.pending?
      flash[:error] = "This invitation is no more pending"
      redirect_to root_url    
    else
      user = User.email_equals(invitation.email).first

      if user_signed_in?
      
        if user.nil? || current_user != user
           flash[:error] = "You are currently logged with a different account, please logout first and retry"  
           redirect_to root_url 
        else
          proceed_to_invitation(invitation)
          flash[:notice] = "You now part of the crew #{invitation.crew.name}"
          redirect_to root_url
        end
      else
        session[:pending_invitation] = invitation
        if user.nil?
          flash[:notice] = "You nearly part of the crew #{invitation.crew.name}, to proceed you'll have to register first with the invited email : \'#{invitation.email}\'"
          redirect_to new_user_registration_path(:user =>{:email => invitation.email})  
        else
          flash[:notice] = "You nearly part of the crew #{invitation.crew.name}, to proceed you'll have to login first with the invited email : \'#{invitation.email}\'"
          redirect_to new_user_session_path(:user =>{:email => invitation.email})        
        end
      end
    end
  end

  private
  def set_user   
    params[:invitation][:user_id] = current_user.id
  end
  
  def send_mail
    @invitation.set_new_token
    @invitation.sent_at = Time.now
    @invitation.save!
    InvitationMailer.deliver_invitation(@invitation)
  end
  


  
end
