class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :scheduled]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.where('published_at IS NULL OR published_at <= ?', Time.current).ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :taggings).order(created_at: :desc)

    if params[:tag_name]
      @posts = @posts.tagged_with("#{params[:tag_name]}")
    end

    @posts = @posts.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    # 予約投稿で現在時刻よりも後の投稿で、かつ現在のユーザーが投稿の作成者でない場合
    if @post.published_at.present? && @post.published_at > Time.current && current_user != @post.user
      redirect_to posts_path
    else
      @comment = Comment.new
      @comments = @post.comments.includes(:user).order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)
    @post.author = current_user
    if @post.save
      redirect_to posts_path, success: t('defaults.message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  def bookmarks
    @q = current_user.bookmark_posts.ransack(params[:q])
    @bookmark_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def scheduled
    @posts = current_user.posts.where('published_at > ?', Time.current).order(created_at: :desc).page(params[:page])
  end

  def received
    @received_posts = current_user.received_posts.includes(:user).where('published_at IS NULL OR published_at <= ?', Time.current).order(created_at: :desc).page(params[:page])
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :food_image, :food_image_cache, :tag_list, :published_at, recipient_ids: [])
  end
end
