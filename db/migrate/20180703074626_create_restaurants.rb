class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string    :res_name     #음식점명
      t.string    :branch_name  #지점명
      t.string    :detail_addr  #상세주소
      t.string    :food_type    #음식종류
      t.string    :image_path   #이미지
      t.string    :parking      #주차유무 
      t.string    :open_hour    #여는시간
      t.string    :close_hour   #닫는시간
      t.integer   :min_price    #최소가격
      t.integer   :max_price    #최대가격
      t.string    :phone        #전화번호
      t.string    :b_number     #사업자번호
      t.string    :breaktime    #breaktime
      t.string    :holiday      #휴무일
      
      #reference
      t.integer   :state_id
      t.integer   :district_id
      t.integer   :road_id
      
      t.timestamps
    end
  end
end
