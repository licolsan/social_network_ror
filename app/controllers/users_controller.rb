class UsersController < ApplicationController

  before_action :get_services, only: [ :edit, :update ]
  before_action :find_user, only: [ :edit, :update ]
  skip_before_action :finish_profile, only: [ :edit, :update ]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user_service.update_user(@user, user_params)
      flash[:notice] = "Your profile has been update!"
      redirect_to root_path
    else
      flash[:notice] = user.errors
      redirect_back(fallback_location: root_path)
    end
  end
  
  private

  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :email, :date_of_birth)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def get_services
    @user_service = UserService.new
  end
end
