class SessionsController < ApplicationController



  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_url,
                  alert: "Invalid user/password combination please try again or register an account"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:basket_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end