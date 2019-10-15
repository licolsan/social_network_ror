class PostService

  def get_all_posts
    Post.all
  end

  def get_post(id)
    Post.find_by(id: id)
  end
  
  def new_post(owner, params: {})
    owner.posts.new(params)
  end

  def save_post(post)
    post.save
  end

  def update_post(post, params: {})
    post.update(params)
  end

  def destroy_post(post)
    post.destroy
  end

  def is_owner(user, post)
    user.id == post.user_id
  end
  
end
