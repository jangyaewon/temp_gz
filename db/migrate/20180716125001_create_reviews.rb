class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :restaurant_id
      
      t.integer :taste_eval
      t.integer :price_eval
      t.integer :service_eval
      
      t.string :image_path
      t.text :contents

      t.timestamps
    end
  end
end
