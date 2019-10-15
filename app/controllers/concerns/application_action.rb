require 'active_support/concern'

module ApplicationAction

  # This module is included by ApplicationController

  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :finish_profile, if: :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :avatar, :date_of_birth ])
	end

  def finish_profile
		if current_user.avatar.blank? || current_user.date_of_birth.blank?
      flash[:notice] = "You need to update profile before continue"
      redirect_to edit_user_path(current_user)
    end
  end

end