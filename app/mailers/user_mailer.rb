class UserMailer < ApplicationMailer

  WELCOME_MAIL_SUBJECT = "Welcome to new social network application"

  def welcome_email
    user = params[:user]
    mail(to: user.email, subject: WELCOME_MAIL_SUBJECT)
  end
end