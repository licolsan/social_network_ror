class UserMailer < ApplicationMailer

  def welcome_email
    user = params[:user]

    mail(
      to: user.email,
      subject: "Welcome to new social network application"
    )
  end

  def notify_new_post
    owner = params[:owner]
    @post = params[:post]
    users = UserService.new.get_follower_of(owner)
    users.each do |user|
      mail(
        to: user.email,
        subject: "New post notification"
      )
    end
  end
end