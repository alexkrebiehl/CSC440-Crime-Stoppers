require 'date'
class UsersController < ApplicationController
  
  def index
    @date1 = params[:date1]
    @date2 = params[:date2]
    @severity = params[:severity] || 0
    if @date1.nil? || @date1.empty?
      @date1 = Date.today
      @date1 = @date1.prev_year
    else
      @date1 = Date.strptime( @date1.gsub("/","-") , '%m-%d-%Y')
    end
    if @date2.nil? || @date2.empty?
      @date2 = Date.today
    else
      @date2 = Date.strptime( @date2.gsub("/","-") , '%m-%d-%Y')
    end 
    @hash = Hash.new(0)
     CrimeType.where(:severity => @severity ).each do |ct|
       count = CrimeRecord.where("crime_type_id = ? and date < ? and date > ?",ct.id, @date2, @date1).count
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
    user = User.where(:email => params[:user]["email"]).first
    if user.nil?
      redirect_to root_url, :notice => "The Account Doesn't Exist!"
    else
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
