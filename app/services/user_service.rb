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

  def get_user(id)
    User.find_by(id: id)
  end

  def find_user(current_user, target_user_id)
    target_user = User.find_by(id: target_user_id)
    if (
      current_user.following?(target_user) ||
      current_user.id == target_user.id
    )
      target_user
    else
      nil
    end
  end

  def update_user(user, attrs)
    user.update_attributes(attrs)
  end

  def send_welcome_email(user)
    UserMailer.with(user: user).welcome_email.deliver_later
  end

  def notify_new_post(user, post)
    users = get_follower_of(user)

    users.each do |u|
      UserMailer.with(
        post: post,
        user: u
      ).notify_new_post.deliver_later
    end

    start_follow(user, post)
  end

  def notify_new_comment(user, comment)
    users =
      comment.followers_by_type(user.class.name) +
      comment.commentable.followers_by_type(user.class.name) -
      [user]

    users.each do |u|
      UserMailer.with(
        owner: user,
        comment: comment,
        user: u
      ).notify_new_comment.deliver_later
    end
    
    start_follow(user, comment)
    start_follow(user, comment.commentable)
  end

  def is_current_user(current_user_id, target_user_id)
    current_user_id == target_user_id
  end

  def get_all_except(user)
    User.all_except(user)
  end

  def get_following_of(user)
    user.following_by_type(user.class.name)
  end

  def get_follower_of(user)
    user.followers_by_type(user.class.name)
  end

  def start_follow(user, target)
    user.follow(target)
  end

  def stop_follow(user, target)
    user.stop_following(target)
  end

end
