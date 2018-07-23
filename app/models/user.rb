class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
      
      has_many  :scrabs
      has_many  :restaurants, through: :scrabs
      has_many  :reviews
      has_many  :likes
 
   def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    #Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20],
            provider: access_token.provider,
            uid: access_token.uid
        )
    end
    user
   end
    
  def self.from_omniauth_kakao(token)
    user = User.where(provider: "kakao",uid: token["id"]).first
    if user
      user
    else
      if token["kakao_account"]["email"].present?
        user_email = token["kakao_account"]["email"]
      else
        user_email = "#{token["id"]}@kakao.com"
      end
      user = User.create(email: user_email,
                  password: Devise.friendly_token[0,20],
                  name: token["properties"]["nickname"],
                  uid: token["id"],
                  provider: "kakao")
    end
    user
  end
  
  #좋아요 기능
  def is_like?(review)
    Like.find_by(user_id: self.id, review_id: review.id).present?
  end
  
  #스크랩 기능
  def is_scrab?(restaurant)
    Scrab.find_by(user_id: self.id,restaurant_id: restaurant.id).present?
  end
  
  #닉네임
  def has_nickname(user)
    @res = User.find_by(id: user.id)
     tmp = Nickname.find_by(id: user.id)
    @res.nickname = tmp.word
    @res.save
    @res.nickname
  end
          
end
