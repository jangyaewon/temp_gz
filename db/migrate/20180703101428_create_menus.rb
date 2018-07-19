class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string    :menu_name
      t.integer   :price
      
      #reference
      t.integer   :restaurant_id
      t.timestamps
    end
  end
end
