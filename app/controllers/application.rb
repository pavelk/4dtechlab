class ApplicationController < ActionController::Base
  include ExceptionLoggable
  
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :set_active_tab
  
  before_filter :check_authentication
  
  add_crumb "TechLab", '/'
    
  def sub_menu
    nil
  end
  
  def sidebar_menu
    nil
  end
  
  protected
    def set_active_tab
      @active_tab ||= self.controller_name.to_sym
    end
    
  private
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def check_authentication
      unless current_user
        store_location
        flash[:error] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      else
        check_authorization
      end  
    end
    
    def check_authorization 
      unless has_right?(current_user)
        store_location
        flash[:error] = "You are not authorized to view the page you requested"
        redirect_to new_user_session_url
        return false
      end
    end

    def has_right?(user)
      user.has_right_for?(action_name, self.class.controller_path)
    end    
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end