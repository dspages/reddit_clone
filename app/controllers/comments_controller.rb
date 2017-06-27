class CommentsController < ApplicationController

  def new
    @comment=Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    flash[:errors] = @comment.errors.full_messages unless @comment.save
    redirect_to post_url(@comment.post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.author_id == current_user.id
      @comment.content = "<-- Deleted -->"
    end
    redirect_to post_url(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end
end
