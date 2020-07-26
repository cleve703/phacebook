class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 3, maximum: 40}

  has_many :friend_requests_sent, class_name: 'Friendship', foreign_key: 'friender_id'
  has_many :friend_requests_received, class_name: 'Friendship', foreign_key: 'friended_id'
  has_many :invitees, through: :friend_requests_sent
  has_many :inviters, through: :friend_requests_received
  
  def make_friend_request(target, origin=self)
    Friendship.create(friender_id: origin.id, friended_id: target.id)
  end

  def accepted_friend_requests
    self.friend_requests_received.where(confirmed:true).each { |inv| inv.friended_id } + 
    self.friend_requests_sent.where(confirmed:true).each { |inv| inv.friender_id }
  end
  
  def friends
    friend_list = []
    accepted_friend_requests.each do |inv|
      friend_list.push(inv.friended_id) unless inv.friended_id == self.id
      friend_list.push(inv.friender_id) unless inv.friender_id == self.id
    end
    User.where(id: friend_list)
  end

  def outstanding_friend_requests
    self.friend_requests_received.where(confirmed:false)
  end

  def confirm_friend_request(id)
    friendship = Friendship.find_by(id:id)
    if friendship.invitee == self
      friendship.update(confirmed: true)
    end
  end

end