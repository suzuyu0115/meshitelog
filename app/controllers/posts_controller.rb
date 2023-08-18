class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :scheduled]
  before_action :set_recipient_ids, only: [:create, :update]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.where('published_at IS NULL OR published_at <= ?', Time.current).ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :taggings).order(created_at: :desc)

    @posts = @posts.tagged_with("#{params[:tag_name]}") if params[:tag_name]

    @posts = @posts.page(params[:page])

    render partial: 'post', collection: @posts, as: :post, status: :ok if request.xhr?
  end

  # 高評価順
  def top_rated
    @q = Post.left_joins(:bookmarks)
      .select('posts.*, COUNT(bookmarks.post_id) AS bookmarks_count')
      .group('posts.id')
      .order('bookmarks_count DESC')
      .where('published_at IS NULL OR published_at <= ?', Time.current)
      .ransack(params[:q])

    @posts = @q.result(distinct: true).includes(:user, :taggings)

    @posts = @posts.tagged_with("#{params[:tag_name]}") if params[:tag_name]

    @posts = @posts.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    # 予約投稿で現在時刻よりも後の投稿で、かつ現在のユーザーが投稿の作成者でない場合
    if @post.future_reserved_post?(current_user)
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

  # お気に入り投稿一覧
  def bookmarks
    @q = current_user.bookmark_posts.ransack(params[:q])
    @bookmark_posts = @q.result(distinct: true).includes(:user, :taggings).order(created_at: :desc).page(params[:page])
  end

  # 送信待ちの投稿一覧
  def scheduled
    @posts = current_user.posts.where('published_at > ?', Time.current).order(created_at: :desc).page(params[:page])
  end

  # 受け取った飯投稿一覧
  def received
    @received_posts = current_user.received_posts.includes(:user, :taggings).where('published_at IS NULL OR published_at <= ?', Time.current).order(created_at: :desc).page(params[:page])
  end

  def search_tags
    query = params[:query]
    @tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{query}%")
    render json: @tags.pluck(:name)
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_recipient_ids
    return unless params[:post][:send_option].present?

    case params[:post][:send_option]
    when 'all'
      params[:post][:recipient_ids] = User.all.pluck(:id)
    when 'random_10'
      params[:post][:recipient_ids] = User.order("RANDOM()").limit(10).pluck(:id)
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :food_image, :food_image_cache, :tag_list, :published_at, recipient_ids: [])
  end
end
