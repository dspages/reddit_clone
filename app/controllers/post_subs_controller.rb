class PostSubsController < ApplicationController

  def create
    @post_sub = PostSub.new(post_sub_params)
    if @post_sub.save
      redirect_to sub_url(@post_sub.sub)
    else
      flash[:errors] = @post_sub.errors.full_messages
      redirect_to subs_url
    end
  end

  def post_sub_params
    params.require(:post_sub).permit(:sub_id,:post_id)
  end

end
