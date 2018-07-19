class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def js_authenticate_user!
      render js: "alert('로그인이 필요합니다');" unless user_signed_in?
  end
end
