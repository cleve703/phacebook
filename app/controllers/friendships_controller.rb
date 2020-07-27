class FriendshipsController < ApplicationController
  before_action :authenticate_user! 

  def create
    @friendship = Friendship.new
    @friendship = current_user.make_friend_request(params[:id])
    @friendship.save
    redirect_back(fallback_location: users_path)
  end

  def update
    @friendship = current_user.find_friendship_with(params[:id])
    if current_user.id == @friendship.friended_id
      @friendship.confirmed = true
      @friendship.save
    end
    redirect_back(fallback_location: users_path)
  end

  def destroy
    @friendship = current_user.find_friendship_with(params[:id])
    Friendship.destroy(@friendship.id)
    redirect_back(fallback_location: users_path)
  end

end
