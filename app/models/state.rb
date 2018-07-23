class State < ApplicationRecord
    validates :state_name, uniqueness: true,
                           presence: true
    
    has_many     :districts
    has_many     :roads
    has_many     :restaurants  
    has_many     :stations
end
