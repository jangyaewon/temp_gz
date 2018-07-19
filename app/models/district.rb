class District < ApplicationRecord
    validates   :district_name, presence: true
    
    belongs_to  :state
    has_many    :roads
    has_many    :restaurants  
end
