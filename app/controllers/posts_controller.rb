class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end
end
