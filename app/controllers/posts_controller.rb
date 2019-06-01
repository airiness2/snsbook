class PostsController < ApplicationController
    
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  before_action :sign_in_user
  
  def index
    @posts = Post.all
  end
  
  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "ブログを作成しました!"
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "ブログを削除しました！"
  end
  
  
  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :user_id, :image, :image_cache)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def sign_in_user
    redirect_to new_session_path unless logged_in?
  end

end
