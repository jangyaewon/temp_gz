class Restaurant < ApplicationRecord
    mount_uploader :image_path,ImageUploader
    
    validates        :res_name,
                     presence: true
    belongs_to       :state
    belongs_to       :district
    belongs_to       :road
    
    has_many         :menus
    has_many         :scrabs
    has_many         :users, through: :scrabs
    has_many         :reviews

    
    def search_restaurant(review)
        @tmp  = Restaurant.where("id LIKE ?","#{review.restaurant_id}")[0]
        @tmp.res_name
    end
 
    def self.search_restaurant_ad(condition)
        unless condition.strip.empty?
            Restaurant.where("detail_addr LIKE ?","%#{condition}%")
        end
    end
   
end
