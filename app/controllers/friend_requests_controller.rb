class FriendRequestsController < ApplicationController

  def new
  end

  def create
    current_user.make_friend_request(User.find_by(id: params[:id]))
  end

  def update
  end

  def delete
  end

end
