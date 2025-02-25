class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: %i[facebook]

  validates :name, length: { minimum: 3, maximum: 40}

  has_many :friend_requests_sent, class_name: 'Friendship', foreign_key: 'friender_id'
  has_many :friend_requests_received, class_name: 'Friendship', foreign_key: 'friended_id'
  has_many :friendeds, through: :friend_requests_sent
  has_many :frienders, through: :friend_requests_received
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_one :profile
  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name  
    end
  end
  
  # Create friendship based on friend object args
  def make_friend_request(target, origin=self)
    Friendship.create(friender_id: origin.id, friended_id: target)
  end

  # List friends by user.friends
  def friends
    friend_list = []
    accepted_friend_requests.each do |inv|
      friend_list.push(inv.friended_id) unless inv.friended_id == self.id
      friend_list.push(inv.friender_id) unless inv.friender_id == self.id
    end
    User.where(id: friend_list)
  end

  # Returns all accepted friend requests for a user as friendship objects
  def accepted_friend_requests
    self.friend_requests_received.where(confirmed:true).each { |inv| inv.friender_id } + 
    self.friend_requests_sent.where(confirmed:true).each { |inv| inv.friended_id }
  end
  
  # Returns all friendship objects received by a user that have not been confirmed
  def outstanding_friend_requests_received
    self.friend_requests_received.where(confirmed:false)
  end

  # Returns all friendship objects sent by a user that have not been confirmed
  def outstanding_friend_requests_sent
    self.friend_requests_sent.where(confirmed:false)
  end

  # Returns boolean based on user object argument indicating whether user sent a friend request to that user
  def user_in_ofrs?(user)
    outstanding_friend_requests_sent.where(friended_id: user.id).exists?
  end

  # Returns boolean based on user object argument indicating whether user received a friend request from that user
  def user_in_ofrr?(user)
    outstanding_friend_requests_received.where(friender_id: user.id).exists?
  end

  def find_friendship_with(id)
    @friendship = Friendship.where(friender_id: self.id, friended_id: id)
    if @friendship[0].nil?
      @friendship = Friendship.where(friended_id: self.id, friender_id: id)
    end
    return @friendship[0]
  end

  def feed
    Post.where("author_id IN (?)", (self.friends.ids.push(self.id)))
  end
end