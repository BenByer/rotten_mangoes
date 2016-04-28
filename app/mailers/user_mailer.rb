class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/deleted'
    mail(to: @user.email, subject: 'You have been erased from existence')
  end  

  def deleted_email(user)
    @user = user
    @url  = 'http://example.com/deleted'
    mail(to: @user.email, subject: 'You have been erased from existence',
      template_path: 'app/views/user_mailer',
      template_name: 'deleted_email.html.erb')
  end

end
