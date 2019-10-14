class PostsController < ApplicationController

  before_action :get_services
  before_action :find_post, only: [ :show, :edit, :update, :destroy ]
  before_action :is_owner, only: [ :edit, :update, :destroy ]

  def index
    @posts = @post_service.get_all_posts
  end

  def show
    @comment = @comment_service.new_comment(@post)
    @comments = @comment_service.get_all_comments(@post)
  end

  def new
    @post = @post_service.new_post(current_user)
  end

  def edit
  end

  def create
    @post = @post_service.new_post(current_user, params: post_params)

    if @post_service.save_post(@post)
      redirect_to @post, notice: "Post was successfully created."
      @user_service.notify_new_post(current_user, @post)
    else
      render :new
    end
  end

  def update
    if @post_service.update_post(@post, post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post_service.destroy_post(@post)
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def find_post
    @post = @post_service.get_post(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :comments_count, images: [])
  end

  def is_owner
    if !@post_service.is_owner(current_user, @post)
      flash[:notice] = "You are not owner of this post."
      redirect_back(fallback_location: root_path)
    end
  end

  def get_services
    @comment_service = CommentService.new
    @post_service = PostService.new
    @user_service = UserService.new
  end
end
