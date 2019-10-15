class UsersController < ApplicationController

  include UserAction

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

end
