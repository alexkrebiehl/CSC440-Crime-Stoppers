class UserNotifier < ActionMailer::Base
  default from: "mekdif@gmail.com"
  
 def send_password_email(user, password)
    @user = user
    mail( :to => @user.email,
    :subject => "Your temporary password", 
    :body => "Your temporary password is\n#{password}\nYou must change it to log on.")
  end
end
