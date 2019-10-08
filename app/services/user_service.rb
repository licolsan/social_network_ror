class UserService
  
  def find_or_create_from_auth(auth)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
  		user.name = auth.info.name
			user.avatar = (auth.info.image + "?type=large") if auth.info.image?
  		user.provider = auth.provider
      user.password = rand().to_s
      user.save!
  	end
  end

  def create_token(user_id)
    JwtHelper.encode(user_id)
  end
end