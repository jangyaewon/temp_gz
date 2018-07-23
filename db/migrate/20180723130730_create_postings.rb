class CreatePostings < ActiveRecord::Migration[5.0]
  def change
    create_table :postings do |t|

      t.text :desc
      t.string :b_user
      t.text :url
      t.string :b_img
      t.string :title
  
      t.integer :restaurant_id


      t.timestamps
    end
  end
end
