class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def index
    @posts = Post.all
    if session[:user_id] !=nil
      @user = User.find(session[:user_id])
    end
  end

  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @author = User.find(@post.user_id)
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(params.require(:post).permit(:title, :body))
        format.html { redirect_to @post, notice: 'The post has been updated' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @post = Post.new
    user = User.find(session[:user_id])
    params.require(:post).permit(:title, :body)
    post_params = params[:post]

    if user
      @post.title = post_params[:title]
      @post.body = post_params[:body]
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
