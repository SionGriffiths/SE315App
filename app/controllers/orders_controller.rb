class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]




  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    # we authorize first so there'll always be a user in the session... heh..
    populate_placeholder_values
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # todo refactor this method... pls!
    @order = Order.new(order_params)

    basket = @basket

    if(basket.line_items.length > 0)
      @order.basket = basket
    else
      redirect_to basket_path basket.id, notice: 'Invalid basket'
      return
    end

    send_data = OrderService.marshal_order_json(@order)
    suppliers = Supplier.all

    suppliers.each do |supplier|
      if send_data[supplier.name]
        send_json = send_data[supplier.name].to_json
        begin
          RestClient.post(supplier.base_rest_url + supplier.new_orders_url, send_json,
                          :content_type => :json, :accept => :json )
        rescue Errno::ECONNREFUSED
          redirect_to root_path, notice: 'Cannot place order currently, try again later'
          return
        end
      end
    end

    respond_to do |format|
      if @order.save
        Basket.destroy(session[:basket_id])
        session[:basket_id] = nil
        format.html { redirect_to root_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :email, :address)
  end

  #we want to populate some values from the current user into the order
  # we don't want to do this in the view so it's here
  def populate_placeholder_values
    current_user = User.find_by_id session[:user_id]
    @order.name = current_user.name
    @order.email = current_user.email
    @order.address = current_user.address
  end

end
