class CreateRoads < ActiveRecord::Migration[5.0]
  def change
    create_table :roads do |t|
      t.string    :road_name
      
      t.integer   :district_id
      t.integer   :state_id
      
      t.timestamps
    end
  end
end
