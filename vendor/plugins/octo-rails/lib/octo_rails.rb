module OctoRails
  
  def self.included base
    base.send :helper_method, :current_user, :logged_in?
    base.send :before_filter, :handle_openid
  end

  def handle_openid opts={}
    if params[:openid_identifier].present?
      params[:openid_identifier] = "https://openid.octo.com/users/" + params[:openid_identifier] if ENV['OCTO_OPEN_ID']
      response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(:identifier => params["openid_identifier"], :required => ['email', "http://axschema.org/contact/email"])
      render :text => 'got openid?', :status => 401
    elsif request.env.has_key?("rack.openid.response")
      authenticate_from_openid_provider_response
    end
  end
  
  def authenticate opts={}
    if logged_in?
      true 
    else
      redirect_access_denied
    end
  end
  
  def authenticate_from_openid_provider_response
    response = request.env["rack.openid.response"]
    if response.status == :success
      set_current_user_from_response response
      redirect_after_auth
    else
      flash[:error] = "OpenID result: #{response.status}"
      render "/sessions/new", :layout => "sessions" unless session[:user]
    end
  end
  
  def redirect_access_denied
    session[:after_login_url] = request.env['REQUEST_URI']
    unless session[:user]
      render "/sessions/new", :layout => "sessions"
    end
  end
  
  def redirect_after_login_url
    if session.has_key? :after_login_url
      redirect_to session[:after_login_url]
      session[:after_login_url] = nil
    else
      redirect_to root_path
    end
  end
  
  def set_current_user_from_response resp
    email = resp.get_signed "http://openid.net/srv/ax/1.0", "value.ext0"
    @user = User.find_by_openid(resp.display_identifier)
    if @user
      # @user.update_attribute :email, email if @user.email.blank? && email
      set_current_user @user.id
    else
      session[:signup] = {:openid => resp.display_identifier, :email => email}
    end
  end
  
  def set_current_user user_id
    session[:user] = user_id
  end
  
  protected
  def redirect_after_auth
    unless logged_in?
      redirect_to :controller => :sessions, :action => :confirm
      return
    end
    redirect_after_login_url
  end
  
  def current_user
    if session[:user]
      @current_user ||= User.find_by_id session[:user]
    end
  end
  
  def logged_in?
    !current_user.nil?
  end

end
