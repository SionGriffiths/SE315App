class ApplicationController < ActionController::Base
  include CurrentBasket
  before_action :set_basket
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize


  #we define some helpful utility methods here so that views can access them
  helper_method :is_logged_in?
  helper_method :get_session_user
  helper_method :get_session_user_name


  def is_logged_in?
    logged_in_user = get_session_user
    !!logged_in_user
  end

  def get_session_user
     User.find_by_id session[:user_id]
  end

  def get_session_user_name
    get_session_user.name
  end

  protected


  def authorize
    unless get_session_user
      redirect_to login_url, notice: "Please log in"
    end
  end


end
