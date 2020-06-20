class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def friend_request(target)
    Friendship.create!(user: self, friend: target, confirmed: false)
  end

  def initiated_unconfirmed_friend_requests(target=self)
    Friendship.where(user: target, confirmed: false)
  end

  def received_unconfirmed_friend_requests(target=self)
    Friendship.where(friend: target, confirmed: false)
  end

end
