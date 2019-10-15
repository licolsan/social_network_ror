require 'active_support/concern'

module UserAction

  # This module is included by UsersController

  extend ActiveSupport::Concern

  included do
    before_action :find_user, only: [ :edit, :update ]
    before_action :is_current_user, only: [ :edit, :update ]
    skip_before_action :finish_profile, only: [ :edit, :update ]
  end

  private
  
  def find_user
    @user = @user_service.get_user(params[:id])
  end

  def is_current_user
    if !@user_service.is_current_user(current_user.id, @user.id)
      flash[:notice] = "You are not allow for this operation"
      redirect_back(fallback_location: root_path)
    end
  end

end