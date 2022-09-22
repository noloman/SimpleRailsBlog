class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    user = User.find_by(session[:user_id])
    params.require(:post).permit(:title, :body)

    if user
      @post.title = params[:post][:title]
      @post.body = params[:post][:body]
      @post.user_id = user.id
      @post.save
    else
      flash[:notice] = "Unable to create post"
      render :new, status: :unprocessable_entity
    end

    if @post
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "Unable to create post"
      render :new, status: :unprocessable_entity
    end
  end
end
