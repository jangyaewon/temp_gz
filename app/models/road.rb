class Road < ApplicationRecord
    validates    :road_name,presence: true
    belongs_to   :state
    belongs_to   :district
    has_many     :restaurants    
    has_many     :stations
end
