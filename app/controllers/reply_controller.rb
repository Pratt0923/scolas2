class ReplyController < ApplicationController
  def index
    @comment = Comment.find(params[:comment_id])
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.new(comment_id: @comment.id, content: params[:reply][:content])
    if @reply.save
      flash[:success] = "Saved!"
    else
      flash[:danger] = "Something went wrong!"
    end
    redirect_to post_comment_index_path
  end

  def destroy
    @reply = Reply.find_by(id: params[:id])
    authorize @reply
    @reply.destroy
    redirect_to post_comment_index_path
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    @reply = Reply.find params[:id]
    authorize @reply
    update_reply(@reply)
  end

  private
  def update_reply(reply)
    if reply.update(
      content: params[:reply][:content]
      )
      flash[:notice] = "Reply updated!"
      redirect_to post_comment_index_path
    else
      render :edit
    end
  end
end
