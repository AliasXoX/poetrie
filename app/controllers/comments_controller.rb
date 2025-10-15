class CommentsController < ApplicationController
  def create
    @poem = Poem.find(params[:poem_id])
    @comment = @poem.comments.new(comment_params)

    if @comment.save
      redirect_to poem_path(@poem), notice: "Comment was successfully created."
    else
      redirect_to poem_path(@poem), alert: "Failed to create comment."
    end
  end

  def update
    @poem = Poem.find(params[:poem_id])
    @comment = @poem.comments.find(params[:id])
    if @comment.update(comment_params_update)
      redirect_to poem_path(@poem), notice: "Comment was successfully updated."
    else
      redirect_to poem_path(@poem), alert: "Failed to update comment."
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:start_position, :end_position, :content)
  end

  def comment_params_update
    params.require(:comment).permit(:content)
  end
end
