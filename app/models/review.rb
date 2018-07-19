class Review < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant
    has_many :likes
    

       
end
