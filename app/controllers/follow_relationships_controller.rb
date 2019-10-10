class FollowRelationshipsController < ApplicationController

  FOLLOWING = "following"
  FOLLOWER = "follower"

  before_action :get_services

  def index
    case params[:type]
    when FOLLOWING
      @users = @user_service.get_following_of(current_user)
    when FOLLOWER
      @users = @user_service.get_follower_of(current_user)
    end
    @users = [] if @users.nil?
    render "users/index"
  end

  def create
    @user_service.start_follow(current_user, User.find(params[:id]))
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user_service.stop_follow(current_user, User.find(params[:id]))
    redirect_back(fallback_location: root_path)
  end

  def get_services
    @user_service = UserService.new
  end
end
