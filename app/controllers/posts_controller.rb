class PostsController < ApplicationController
  before_action :check_login

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
      flash[:notice] = 'Category has been created'
    else
      render :new
    end
  end

  private

  def check_login
    if !current_user
      redirect_to new_user_registration_path
    end
  end

  def post_params
    params.require(:post).permit(:url, :category_id)
  end
end
