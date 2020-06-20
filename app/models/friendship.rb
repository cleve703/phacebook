class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def confirm_friend_request(target=self)
    self.update!(confirmed: true)
  end

end
