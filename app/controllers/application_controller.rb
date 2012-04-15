class ApplicationController < ActionController::Base
  before_filter :set_user
  protect_from_forgery
  
  def set_user
    if user_signed_in?
      @user = current_user
    end
  end
end
