class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      current_user = user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def user_params
    params.require(:user).permit!
  end
end
