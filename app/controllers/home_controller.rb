class HomeController < ApplicationController
  include CurrentBasket
  before_action :set_basket

  def index
  end

end
