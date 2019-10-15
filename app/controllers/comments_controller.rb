class CommentsController < ApplicationController

  include CommentAction

  def show
  end

  def edit
  end

  def create
    inputs = comment_params.merge({ user: current_user })
    unless params[:comment_id].nil? # is this child coment?
      parrent_comment = @comment_service.get_comment(params[:comment_id])
      @comment = @comment_service.new_comment(parrent_comment, params: inputs)
    else
      @comment = @comment_service.new_comment(@post, params: inputs)
    end

    if @comment_service.save_comment(@comment)
      @user_service.notify_new_comment(current_user, @comment)
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @comment_service.update_comment(@comment, params: comment_params)
      redirect_to post_path(@comment.commentable)
    else
      render :edit
    end
  end

  def destroy
    @comment_service.destroy_comment(@comment)
    redirect_to post_path(@post), notice: "Comment was successfully destroyed."
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end

end
