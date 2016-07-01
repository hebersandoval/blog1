class CommentsController < ApplicationController
  # def show
  #   @comment = Comment.find(params[:id])
  # end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:success] = "Comment was created."
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "Comment has not been created."
      render "posts/show"
    end
  end

  def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
    flash[:success] = "Comment was deleted."

		redirect_to post_path(@post)
	end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
