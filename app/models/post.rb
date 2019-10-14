class Post < ApplicationRecord

  belongs_to :owner, class_name: "User", counter_cache: true, foreign_key: "user_id"
  has_many_attached :images
  has_many :comments, as: :commentable, inverse_of: :commentable

  validates :title, presence: true
  validates :content, presence: true
  validates :images, presence: true

end
