class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
  
    def index
      @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      @posts = @posts.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
    end
  
    def show
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to posts_path, notice: 'Post is successfully created.'
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        redirect_to new_post_path
      end
    end
  
    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to posts_path, notice: 'Post is successfully updated.'
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        redirect_to edit_post_path(@post)
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_url, alert: 'Post is successfully destroyed.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
  
