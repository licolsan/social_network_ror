class CommentService

  def get_all_comments(parent)
    parent.comments.all.includes("comments") # optimize for N+1 query issue
  end

  def get_comment(id)
    Comment.find(id)
  end

  def new_comment(parent, params: {})
    parent.comments.new(params)
  end

  def save_comment(comment)
    comment.save
  end

  def update_comment(comment, params: {})
    comment.update(params)
  end

  def destroy_comment(comment)
    comment.destroy
  end

  def is_owner(user, comment)
    comment.user_id == user.id
  end

  def is_destroyable(user, comment)
    (
      is_owner(user, comment) ||
      (
        comment.commentable.class.name == Post.name &&
        comment.commentable.user_id == user.id
      )
    )
  end

end
