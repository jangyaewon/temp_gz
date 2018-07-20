class ReviewsController < ApplicationController
  before_action :js_authenticate_user!, only: [:like_review]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    
    #유저는 한 식당에 한번의 리뷰만 쓸 수 있다.
    # if current_user.reviews.restaurant_id?
    #   redirect_to @review.errors,flash:{note: '리뷰는 한번만.'}
    # else
    #   @review.save
    #   redirect_to @review,flash:{success: 'Review was successfully created.'}
    # end
      
    if @review.save
      # redirect_to @review, flash:{success: 'Review was successfully created.'}
        redirect_to restaurant_url(@review.restaurant_id), flash:{success: 'Review was successfully created.'}
    else
      render :new
    end
    
    
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #summer note - upload image
  def upload_image
    @image = Image.create(image_path: params[:upload][:image])
    p @image
    render json: @image
  end
  
  
  # 리뷰 좋아요
  def like_review
    p params
    #현재 유저와 params에 담긴 movie 간의
    #좋아요 관계를 설정한다.
      
    #where의 결과값은 배열이다.
    #따라서 .first를 이용해 맨 앞 한가지만.
    @like = Like.where(user_id: current_user.id,review_id: params[:review_id]).first
    p '------review_id---------------'
    p params[:review_id]
  
    if @like.nil?
      #새로 누른 경우
      #좋아요 관계 설정
      @like = Like.create(user_id: current_user.id,review_id: params[:review_id])
      puts "좋아요 설정 끝"
      puts @like.frozen?
      # p '---------------------22'
      # p params[:review_id]
      # user_likes_review
      redirect_to :back
  
    else
      #만약에 현재 로그인한 유저가 이미 좋아요를 눌렀을 경우
      #해당 Like 인스턴스 삭제
      @like.destroy
      # user_likes_review
      puts "좋아요 취소 끝"
      puts @like.frozen?
      redirect_to :back
    end
    
  end
  
  # def user_likes_review
  #   @result = Like.where(user_id: current_user.id, review_id: params[:review_id]).first if user_signed_in?
  #   p '-----------result----------'
  #   p @result
  # end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :taste_eval,:price_eval,:service_eval,:contents, :restaurant_id,:image_path)
    end
end
