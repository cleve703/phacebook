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

end
