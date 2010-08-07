class SessionsController < ApplicationController
  
  skip_filter :authenticate, :only => [:confirm]
  
  def logout
    session.clear
    redirect_to root_url
  end
  
  def new
    render :layout => "sessions"
  end
  
  def confirm
    if request.post?
      @user = User.new params[:user]
      if @user.save
        set_current_user @user.id
        session[:signup] = nil
        redirect_to root_path
      end
    else
     if session[:signup]
        @user = User.new session[:signup]
        @user.nickname = @user.email.split("@").first if @user.email.present?
      else
        render :status => 404, :nothing => true
      end
    end
  end
  
end