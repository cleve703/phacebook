class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.image.attach(post_params[:image])
    @post.body = post_params["body"]
    @post.title = post_params["title"]
    @post.author_id = current_user.id
    @post.save
    redirect_back(fallback_location: posts_path)
  end

  private

    def post_params
      post_params = params.require(:post).permit(:title, :body, :image)
    end

end
