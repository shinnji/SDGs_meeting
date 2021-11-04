class PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tags = Vision.get_image_data(@post.image)    
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to posts_path
    else
      byebug
      render :new
    end 
    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  def search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(3)
    @keyword = params[:keyword]
    render "index"
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
