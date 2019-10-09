# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController

  before_action :get_services, only: [ :show ]

  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
    @user_service.send_welcome_email(resource) if resource.errors.empty?
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    super(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
  end

  private
  
  def get_services
    @user_service = UserService.new
  end
end
