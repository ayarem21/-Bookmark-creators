class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  require 'nokogiri'
  require 'open-uri'

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    # if @post.save
    #   redirect_to root_path
    #   flash[:notice] = 'Category has been created'
    # else
    #   render :new
    # end
    site = Nokogiri::HTML.parse(open(post_params["url"]))
    resource = site.css('a h1').first
    if(resource != nil)
      resource = site.css('a h1').first.text
      title = site.css('div.content-single__block div.content-single__block_title h1').text
      body = site.css('div.content-single__block div.content-single__block_text div.content-single__block_text_body p').text
      image = site.css('div.content-single__block__img img').attr('src')
    else
      resource = site.css('img').first.attr('alt')

      title = site.css('div.publication-text-area.text-container h1').text
      body = site.css('div.publication-text-area.text-container div.publication-sticky-container p').text
      image = site.css('div.publication-sticky-container div.publication-img-wrapper img').first.attr('src')
    end



    puts resource
    puts title
    puts body
    puts image
    puts post_params["url"]
    @post = Post.new(title: title, body: body, url: post_params["url"], image: image, category_id: post_params["category_id"], resource: resource)
    if @post.save
      redirect_to root_path
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

  def set_post
    @post = Post.find(params[:id])
  end
end
