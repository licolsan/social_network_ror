class UserMailer < ApplicationMailer

  def welcome_email
    user = params[:user]

    mail(
      to: user.email,
      subject: "Welcome to new social network application"
    )
  end

  def notify_new_post
    @post = params[:post]
    user = params[:user]
    
    mail(
      to: user.email,
      subject: "New post notification"
    )
  end

  def notify_new_comment
    @owner = params[:owner]
    @comment = params[:comment]
    user = params[:user]

    mail(
      to: user.email,
      subject: "New comment notification"
    )
  end

end
