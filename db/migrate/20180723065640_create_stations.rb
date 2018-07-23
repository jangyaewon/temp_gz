class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.integer :state_id
      t.integer :road_id
      t.integer :district_id
      
      t.string  :station_name
      t.string  :latitude
      t.string  :longitude
      
      t.timestamps
    end
  end
end
