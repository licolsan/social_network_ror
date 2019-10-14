class UsersController < ApplicationController

  before_action :get_services
  before_action :find_user, only: [ :edit, :update ]
  before_action :is_current_user, only: [ :edit, :update ]
  skip_before_action :finish_profile, only: [ :edit, :update ]

  def index
    @users = @user_service.get_all_except(current_user)
  end

  def show
    @user = @user_service.find_user(current_user, params[:id])
    redirect_back(fallback_location: root_path) if @user.nil?
  end

  def edit
  end

  def update
    if @user_service.update_user(@user, user_params)
      flash[:notice] = "Your profile has been update!"
    else
      flash[:notice] = user.errors
    end
    redirect_back(fallback_location: root_path)
  end
  
  private

  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :email, :date_of_birth)
  end

  def find_user
    @user = @user_service.get_user(params[:id])
  end

  def is_current_user
    if !@user_service.is_current_user(current_user.id, @user.id)
      flash[:notice] = "You are not allow for this operation"
      redirect_back(fallback_location: root_path)
    end
  end

  def get_services
    @user_service = UserService.new
  end
end
