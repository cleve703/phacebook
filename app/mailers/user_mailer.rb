class UserMailer < ApplicationMailer
  default from: 'phacebook@codingcop.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'codingcop.com'
    mail(to: @user.email, subject: 'Welcome to Phacebook')
  end
end
