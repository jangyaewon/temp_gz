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
    @d = District.find(@restaurant.district_id)
    @restaurant.blog_desc(@d.district_name, @restaurant.id)
    @posts = Posting.where(restaurant_id: @restaurant.id)
    
    
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
###############################################  
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
###########################################################
  def search_result
    temp = params[:query]
    p "?????????????"
    if params[:query].include?("역")
      p temp
      ind = temp.index('역') -1
      str = temp[0..ind]
      puts "************************"
      p str
      @station = Station.find_by_station_name(str)
      @restaurants = Restaurant.where(road_id: @station.road_id).page params[:page]
    else
       temp = temp[0..1]
       @restaurants = Restaurant.search_restaurant_ad(temp).order('r_count desc').page params[:page]
    end
   
     respond_to do |format|
      format.html { render :action => "search_result" }
      format.xml  { render :xml => @restaurants }
    end
  end
############################################ 
  
    #해시태그
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @restaurants = tag.restaurants
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:res_name,:branch_name,:detail_addr,:food_type,:open_hour,
                                         :close_hour,:contents,:min_price,:max_price,:phone,:b_number,:image_path)
    end
    
    def blog_desc
      Restaurant.blog_desc(params[:query].to_s) #기본적으로 스트링으로 넘어오긴한데 굳이 인티저로 하는등 이런걸 방지. query를 데이터베이스에 넣을 필요없이 가져오기만하면되기 때문에 여기에 이런 파람스를 넣겠다 라는 뜻만 가지면 됨.
      redirect_to root_path #크롤링한다음에 리프레쉬
    end
end
