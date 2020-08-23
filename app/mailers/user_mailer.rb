class UserMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid
 
  def welcome_email(user)
    @user = user
    @url  = 'codingcop.com'
    if @user.email[-9..-1] == "email.com"
      return
    end
    from = SendGrid::Email.new(email: 'no-reply@codingcop.com')
    to = SendGrid::Email.new(email: @user.email)
    subject = 'Welcome to Phacebook'
    content = SendGrid::Content.new(type: 'text/plain', value: 'The best new web app around.')
    mail = SendGrid::Mail.new(from, subject, to, content)
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    # puts response.parsed_body
    puts response.headers
  
  end




end
