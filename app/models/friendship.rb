class Friendship < ApplicationRecord
  validates :friender_id, uniqueness: { scope: :friended_id }
  validates :friender_id, exclusion: { in: ->(friendship) { [friendship.friended_id] }, message: "User cannot friend himself/herself." }
  
  belongs_to :friender, class_name: 'User', foreign_key: 'friender_id'
  belongs_to :friended, class_name: 'User', foreign_key: 'friended_id'

end
