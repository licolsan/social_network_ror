class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :commentable, counter_cache: true, polymorphic: true
  has_many :comments, as: :commentable, inverse_of: :commentable, dependent: :destroy
  has_one_attached :image

  validates :content, presence: true
  
end
