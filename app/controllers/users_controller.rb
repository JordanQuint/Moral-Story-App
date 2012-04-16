class UsersController < ApplicationController

  def show
    @title = "Profile"
    @user_viewing = User.find(params[:id])
  end

  def destroy
  end
  
  def follow
    user = User.find(params[:user])
    if @user.is_following(user)
      follow = Subscription.find_by_user_id_and_subscribed_to_and_target_id(@user.id, "users", user.id)
      Subscription.delete(follow)
    else
      Subscription.create(:user_id => @user.id,
                          :subscribed_to => "users",
                          :target_id => user.id)
    end
    redirect_to :back
  end

end
