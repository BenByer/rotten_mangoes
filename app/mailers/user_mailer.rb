class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/deleted'
    mail(to: @user.email, subject: 'You have been erased from existence')
  end  

  def deleted_email(user)
    @user = user
    @url  = 'localhost:3000'
    puts "UserMailer @user #{@user}"
    mail(to: @user.email, subject: 'You have been erased from existence')
  end

end
