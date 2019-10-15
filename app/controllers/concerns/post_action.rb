require 'active_support/concern'

module PostAction

  # This module is included by PostsController

  extend ActiveSupport::Concern

  included do
    before_action :find_post, only: [ :show, :edit, :update, :destroy ]
    before_action :is_owner, only: [ :edit, :update, :destroy ]
  end

  private

  def find_post
    @post = @post_service.get_post(params[:id])
  end

  def is_owner
    if !@post_service.is_owner(current_user, @post)
      flash[:notice] = "You are not owner of this post."
      redirect_back(fallback_location: root_path)
    end
  end

end