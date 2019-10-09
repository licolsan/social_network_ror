require 'open-uri'

class UserService
  
  def find_or_create_from_auth(auth)
    User.find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |user|
			user.email = auth.info.email
      user.name = auth.info.name
      user.avatar.attach(
        io: open(auth.info.image + "?type=large"),
        filename: 'file-name.jpg'
      ) if auth.info.image?
  		user.provider = auth.provider
      user.skip_password_validation = true
      user.save!
  	end
  end

  def update_user(user, attrs)
    user.update_attributes(attrs)
  end

  def send_welcome_email(user)
    UserMailer.with(user: user).welcome_email.deliver_later
  end
end