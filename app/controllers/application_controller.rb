class ApplicationController < ActionController::Base
  include CurrentBasket
  before_action :set_basket


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
