require 'active_support/concern'

module ServiceAction

  # This module is included by ApplicationController

  extend ActiveSupport::Concern

  included do
    before_action :get_services
  end

  private

  def get_services
    @comment_service = CommentService.new
    @post_service = PostService.new
    @user_service = UserService.new
  end

end