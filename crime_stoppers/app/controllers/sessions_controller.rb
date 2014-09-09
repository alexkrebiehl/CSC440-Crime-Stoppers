class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      current_user = user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in!"
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
