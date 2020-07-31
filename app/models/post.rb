class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
  default_scope -> { order(created_at: :desc) }
  has_one_attached :image
  validates :author_id, presence: true
  validates :body, presence: true, length: { maximum: 1500 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                              size: { less_than: 5.megabytes,
                                      message:    "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [240, 240])
  end
end
