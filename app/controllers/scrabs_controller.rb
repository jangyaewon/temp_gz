class ScrabsController < ApplicationController
    def scrab_toggle
        scrab = Scrab.find_by(user_id: current_user.id, restaurant_id: params[:restaurant_id])
    
         if scrab.nil?
            Scrab.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])  
         else
            scrab.destroy
         end
         redirect_to :back        
    end
end
