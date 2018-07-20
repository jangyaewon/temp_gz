class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
      :type => "buttons",
      buttons: ["소개", "원하는 식당 검색", "공자맛집으로 이동하기"]
    }
    render json: @keyboard
  end
  
  def message
    @user_msg = params[:content]
    @text = "기본 텍스트"
    
    if @user_msg == "소개"
      @text = "안녕하세요. 저희는 공무원들의 업무추진비를 통해 공무원들이 자주 가는 맛집을 알리는 공자맛집입니다."
    elsif @user_msg == "원하는 식당 검색"
      @text = "알고싶은 주소를 입력해주세요\n ex) 강남역 맛집"
    elsif @user_msg == "공자맛집으로 이동하기"  
      @url = "https://gongin-mat-zip-wonwon.c9users.io/"
    else
      @url = "https://gongin-mat-zip-wonwon.c9users.io/"
      @temp = @user_msg[0..1]
      @restaurant = Restaurant.where("detail_addr LIKE ?","%#{@temp}%")[0]

      if @restaurant.nil?
        @text2 = "해당 위치에 대한 결과값이 없네요...."
      else
        @text2 = @restaurant.res_name + "을(를) 추천합니다.\n\n 최근 6개월 간 " + @restaurant.g_name + "이(가) " + @restaurant.r_count + "번 방문한 곳입니다."
      end  
    end
    
    @return_msg = {
      :text => @text
    }
    
    @return_msg_photo = {
      :text => "공자맛집",
      :photo => {
        :url => "https://blogfiles.pstatic.net/MjAxODA3MThfMjg0/MDAxNTMxOTAwODkwNjc5.-W5zlf-w3tin1I7WY1hwnDJFQAFtu4xZBWf4QQ_8qcMg.E1tJ3EmJDFkfi3IWDOwVd5XlzKZe0CRSrv-fLcpoPK8g.JPEG.rainsimple/GongZa-logo.jpg",
        :width => 400,
        :height => 355 
      },
      message_button: {
        label: "공자맛집으로 이동하기",
        url: @url
      }
    }
    
     @return_res_msg = {
      :text => @text2,
      :photo => {
        :url => "https://blogfiles.pstatic.net/MjAxODA3MThfMjg0/MDAxNTMxOTAwODkwNjc5.-W5zlf-w3tin1I7WY1hwnDJFQAFtu4xZBWf4QQ_8qcMg.E1tJ3EmJDFkfi3IWDOwVd5XlzKZe0CRSrv-fLcpoPK8g.JPEG.rainsimple/GongZa-logo.jpg",
        :width => 400,
        :height => 355 
      },
      message_button: {
        label: "공자맛집에서 다른 맛집들 찾아보기",
        url: @url
      }
    }
    
  
    @return_keyboard = {
      :type => "buttons",
      buttons: ["소개", "원하는 식당 검색", "공자맛집으로 이동하기"]
    }
    
    if @user_msg == "소개"
      @result = {
      :message => @return_msg,
      :keyboard => @return_keyboard
    }elsif @user_msg == "원하는 식당 검색"
      @result = {
      :message => @return_msg,
      :keyboard => @basic_keyboard
    }
    elsif @user_msg == "공자맛집으로 이동하기"
      @result = {
      :message => @return_msg_photo,
      :keyboard => @return_keyboard
    }
    else
      @result ={
      :message => @return_res_msg,
      :keyboard => @return_keyboard
    }
    end
    
    render json:@result
  end
end

