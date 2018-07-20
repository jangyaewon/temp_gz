class CreateRestaurantsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants_tags, :id => false do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
