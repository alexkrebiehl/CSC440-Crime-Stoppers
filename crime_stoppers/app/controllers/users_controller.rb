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

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes!(user_params)
    redirect_to root_url, notice: "Successfully updated your profile"
  end

  def user_params
    params.require(:user).permit!
  end
end
