class UsersController < ApplicationController

  def show
    @title = "Profile"
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.save
  end

  def new
    @title = "Signup"
    @user = User.new
  end

  def destroy
  end

  def login
  end

  def logout
  end

end
