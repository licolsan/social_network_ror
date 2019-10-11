class User < ApplicationRecord
	
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable,
				 :confirmable ,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
				 
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true
	validates :avatar, presence: true
	has_one_attached :avatar
	has_many :posts

	acts_as_follower
	acts_as_followable

	attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

	scope :all_except, -> (user) { where.not(id: user.id) }

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
