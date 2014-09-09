class User < ActiveRecord::Base
   has_secure_password 

   def self.find_or_create_from_email(email)
     password = SecureRandom.base64
     User.where(email: email.downcase).first_or_create!(password: password, password_confirmation: password)
   end

end
