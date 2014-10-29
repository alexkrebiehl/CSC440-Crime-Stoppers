require 'date'
class UsersController < ApplicationController
  
  def index
    @hash = Hash.new(0)
    CrimeType.all.each do |ct|
      count = CrimeRecord.where(:crime_type_id => ct.id).count
      @hash[ct.name] = count
    end
  end

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

  def forget_password_form
    render 'users/forget'
  end 

  def forgot_password
    if user.nil?
      redirect_to root_url, :notice => "The Account Doesn't Exist!"
    else
      user = User.where(:email => params[:user]["email"]).first
      password  = SecureRandom.base64
      user.password = password
      user.password_confirmation = password
      user.force_password = true
      user.save
      UserNotifier.send_password_email(user,password).deliver
      redirect_to root_url, :notice => "Reminder sent" 
    end
  end

  def user_params
    params.require(:user).permit!
  end
end
