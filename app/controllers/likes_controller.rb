class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new
    @like.likeable_type = like_params[:likeable_type]
    @like.likeable_id = like_params[:likeable_id]
    @like.user_id = like_params[:user_id]
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(likeable_type: like_params[:likeable_type], likeable_id: like_params[:likeable_id], user_id: like_params[:user_id])
    Like.destroy(@like.id)
    redirect_back(fallback_location: root_path)
  end

  private

    def like_params
      params.require(:like).permit(:likeable_type, :likeable_id, :user_id)
    end

end
