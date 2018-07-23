class Nickname < ApplicationRecord

    def random1
      @res = Nickname.find(rand((Nickname.last.id + 1)))
      @res.word
    end
    
end
