class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
end
