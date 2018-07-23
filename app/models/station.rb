class Station < ApplicationRecord
    belongs_to   :state
    belongs_to   :district
    belongs_to   :road
end
