class CommentsController < ApplicationController

  before_action :get_services
  before_action :find_post, only: [ :edit, :create, :destroy ]
  before_action :find_comment, except: [ :create ]
  before_action :is_editable, only: [ :edit, :update ]
  before_action :is_destroyable, only: [ :destroy ]

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

  def find_comment
    @comment = @comment_service.get_comment(params[:id])
  end

  def find_post
    @post = @post_service.get_post(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :image)
  end

  def is_editable
    if !@comment_service.is_owner(current_user, @comment)
      flash[:notice] = "You are not allow to edit on this comment"
      redirect_back(fallback_location: root_path)
    end
  end

  def is_destroyable
    if !@comment_service.is_destroyable(current_user, @comment)
      flash[:notice] = "You are not permited on this comment"
      redirect_back(fallback_location: root_path)
    end
  end

  def get_services
    @comment_service = CommentService.new
    @post_service = PostService.new
    @user_service = UserService.new
  end

end
