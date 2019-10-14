class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, inverse_of: :commentable, dependent: :destroy
  has_one_attached :image
  
end
