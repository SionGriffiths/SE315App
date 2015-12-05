class WinesController < ApplicationController
  before_action :set_current_page, except: [:index]
  before_action :set_wine, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize
  # GET /wines
  # GET /wines.json
  def index



    if params[:search].blank? #check for search terms in params
      @wines = Wine.paginate(page: params[:page],
                             per_page: params[:per_page])
                   .order(:name)
    else
      @wines = Wine.search(params[:search])
                   .paginate(page: params[:page],
                             per_page: params[:per_page])
                   .order(:name)
    end
  end


  # GET /wines/1
  # GET /wines/1.json
  def show

  end

  # GET /wines/new
  def new
    @wine = Wine.new
  end

  # GET /wines/1/edit
  def edit
  end

  # POST /wines
  # POST /wines.json
  def create
    @wine = Wine.new(wine_params)

    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, notice: 'Wine was successfully created.' }
        format.json { render :show, status: :created, location: @wine }
      else
        format.html { render :new }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wines/1
  # PATCH/PUT /wines/1.json
  def update
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: 'Wine was successfully updated.' }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.json
  def destroy
    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url, notice: 'Wine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wine
    @wine = Wine.find(params[:id])
  end

  #pagination
  def set_current_page
    @current_page = params[:page] || 1
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wine_params
    params.require(:wine).permit(:name, :description, :short_description, :country_of_origin, :grape_type, :vegetarian, :price, :supplier_id, :pic_url)
  end

end
