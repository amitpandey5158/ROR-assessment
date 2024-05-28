class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to @post, notice: 'Liked.'
    else
      redirect_to @post, alert: 'Something went wrong.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)
    @like.destroy
    redirect_to @post, notice: 'Unliked.'
  end
end

