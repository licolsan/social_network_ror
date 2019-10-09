class User < ApplicationRecord
	
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable,
				 :confirmable ,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
				 
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true
	validates :avatar, presence: true
	has_one_attached :avatar

	attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
