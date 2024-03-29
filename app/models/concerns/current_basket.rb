module CurrentBasket
  extend ActiveSupport::Concern

  #This class is based off the examples in the course textbook - Agile Web Development with Rails

  private
  #Method to set @basket reference to be session basket
  #Or create session basket if none exists
  def set_basket
    @basket = Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    @basket = Basket.create
    session[:basket_id] = @basket.id
  end

end