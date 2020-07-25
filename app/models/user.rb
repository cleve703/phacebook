class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 3, maximum: 40}

  has_many :invitations_sent, class_name: 'Friendship', foreign_key: 'inviter_id'
  has_many :invitations_received, class_name: 'Friendship', foreign_key: 'invitee_id'
  has_many :invitees, through: :invitations_sent
  has_many :inviters, through: :invitations_received
  
  def make_friend_request(target, origin=self)
    Friendship.create(inviter_id: origin.id, invitee_id: target.id)
  end

  def accepted_invitations
    self.invitations_received.where(confirmed:true).each { |inv| inv.invitee_id } + 
    self.invitations_sent.where(confirmed:true).each { |inv| inv.inviter_id }
  end
  
  def friends
    friend_list = []
    accepted_invitations.each do |inv|
      friend_list.push(inv.invitee_id) unless inv.invitee_id == self.id
      friend_list.push(inv.inviter_id) unless inv.inviter_id == self.id
    end
    User.where(id: friend_list)
  end

  def outstanding_friend_requests
    self.invitations_received.where(confirmed:false)
  end

  def confirm_friend_request(id)
    friendship = Friendship.find_by(id:id)
    if friendship.invitee == self
      friendship.update(confirmed: true)
    end
  end


end