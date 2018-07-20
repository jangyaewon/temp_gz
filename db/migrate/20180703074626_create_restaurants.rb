class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string    :res_name     #음식점명
      t.string    :detail_addr  #상세주소
      t.string    :latitude     
      t.string    :longitude  
      
      t.string    :food_type    #음식종류
      t.string    :image_path   #이미지
      t.string    :parking      #주차유무 
      t.string    :phone        #전화번호
      t.string    :b_number     #사업자번호
      t.string    :g_name       #공무원 부처이름
      
      t.integer   :r_count      #공무원들이 간 횟수
      t.integer   :min_price    #최소가격
      t.integer   :max_price    #최대가격
      
      t.text      :b_hour       #영업시간(휴무일 / breaktime 추가)
      
      #reference
      t.integer   :state_id
      t.integer   :district_id
      t.integer   :road_id
      
      t.timestamps
    end
  end
end
