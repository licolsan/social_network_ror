require 'active_support/concern'

module CommentAction

  # This module is included by CommentsController

  extend ActiveSupport::Concern

  included do
    before_action :find_comment, except: [ :create ]
    before_action :find_post, only: [ :edit, :create, :destroy ]
    before_action :is_editable, only: [ :edit, :update ]
    before_action :is_destroyable, only: [ :destroy ]
  end

  private

  def find_comment
    @comment = @comment_service.get_comment(params[:id])
  end

  def find_post
    @post = @post_service.get_post(params[:post_id])
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

end