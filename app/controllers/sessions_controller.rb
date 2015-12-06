class SessionsController < ApplicationController

  #This class is based off the examples in the course textbook - Agile Web Development with Rails


  skip_before_action :authorize

  # We want to keep a reference of where a user wanted to go when redirected to login
  def new
    flash[:ref_url] = request.referer
  end

  # do user login, if redirected to /login then redirect to previous request url after success

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      if flash[:ref_url] && flash[:ref_url] != login_url
        redirect_to flash[:ref_url]
      else
        redirect_to root_path
      end

    else
      redirect_to login_url,
                  alert: "Invalid user/password combination please try again or register an account"
    end
  end

  #logout functionality, clear session
  def destroy
    session[:user_id] = nil
    session[:basket_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
