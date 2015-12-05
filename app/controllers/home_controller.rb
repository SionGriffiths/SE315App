class HomeController < ApplicationController
  include CurrentBasket
  before_action :set_basket
  skip_before_action :authorize

  def index
  end

end
