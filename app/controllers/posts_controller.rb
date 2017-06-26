class PostsController < ApplicationController
  before_action :require_logged_in

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    post_sub=PostSub.new
    post_sub.sub_id = params[:post][:sub_id].to_i
    @post.author_id = current_user.id
    if @post.save
      post_sub.post_id = @post.id
      post_sub.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.subs.first)
    end
  end

  def edit
    @post= Post.find(params[:id])
  end

  def update
    @post= Post.find(params[:id])
    return unless @post.author == current_user
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post= Post.find(params[:id])
    return unless @post.author == current_user
    @post.delete
    redirect_to(sub_url(@post.subs.first))
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
