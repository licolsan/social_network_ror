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

  def is_current_user(current_user_id, target_user_id)
    current_user_id == target_user_id
  end

  def get_all_except(user)
    User.all_except(user)
  end

  def get_following_of(current_user)
    current_user.following_by_type(current_user.class.name)
  end

  def get_follower_of(current_user)
    current_user.followers_by_type(current_user.class.name)
  end

  def start_follow(current_user, target_user)
    current_user.follow(target_user)
  end

  def stop_follow(current_user, target_user)
    current_user.stop_following(target_user)
  end
end