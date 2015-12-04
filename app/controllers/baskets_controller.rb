class BasketsController < ApplicationController
  include CurrentBasket

  #This class is based off the examples in the course textbook - Agile Web Development with Rails

  before_action :set_basket, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_basket

  # GET /baskets
  # GET /baskets.json
  def index
    @baskets = Basket.all
  end

  # GET /baskets/1
  # GET /baskets/1.json
  def show

  end

  # GET /baskets/new
  def new
    @basket = Basket.new
  end

  # GET /baskets/1/edit
  def edit
  end

  # POST /baskets
  # POST /baskets.json
  def create
    @basket = Basket.new(basket_params)

    respond_to do |format|
      if @basket.save
        format.html { redirect_to @basket, notice: 'Basket was successfully created.' }
        format.json { render :show, status: :created, location: @basket }
      else
        format.html { render :new }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baskets/1
  # PATCH/PUT /baskets/1.json
  def update
    respond_to do |format|
      if @basket.update(basket_params)
        format.html { redirect_to @basket, notice: 'Basket was successfully updated.' }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { render :edit }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baskets/1
  # DELETE /baskets/1.json
  def destroy
    #Limit destroy to in-session basket so user cannot destroy anothers basket
    @basket.destroy if @basket.id == session[:basket_id]
    session[:basket_id] = nil
    respond_to do |format|
      format.html { redirect_to wines_url, notice: 'Basket was successfully emptied.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_basket
    @basket = Basket.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def basket_params
    params[:basket]
  end

  def invalid_basket
    logger.error "Attempted to access invalid basket #{params[:id]}"
    redirect_to wines_url, notice: 'Invalid Basket'
  end

end
