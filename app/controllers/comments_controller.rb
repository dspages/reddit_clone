class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to post_url(@comment.post)
  end
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.author_id == current_user.id
      @comment.content = " <-- Deleted -->"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent)
  end
end
