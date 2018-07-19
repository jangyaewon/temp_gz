class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    # @tmp1 = 5-@restaurant.reviews.taste_eval
    # @tmp2 = 5-@restaurant.reviews.service_eval
    # @tmp3 = 5-@restaurant.reviews.price_eval
    # p 'mmmmmmmmmmm'
    p @tmp1
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      @restaurant.state_id = 1;
      @restaurant.district_id =1;
      @restaurant.road_id = 1;
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
 #식당 검색
  def search_restaurant
    respond_to do |format|
      if params[:q].strip.empty?
        format.js {render 'no_content'}
      else
        @restaurants = Restaurant.where("res_name LIKE ?","#{params[:q]}%")
        format.js {render 'search_restaurant'}
      end
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:res_name,:branch_name,:detail_addr,:food_type,:open_hour,
                                         :close_hour,:min_price,:max_price,:phone,:b_number,:image_path)
    end
end
