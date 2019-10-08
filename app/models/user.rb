class User < ApplicationRecord
	
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable,
				 :confirmable ,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
				 
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true
	# validates :date_of_birth, presence: true
	# validates :avatar, presence: true
end
