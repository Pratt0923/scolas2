class CommentController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
  end

  def new
  end

  def create
    @comment = new_comment_params
    if @comment.save
      flash[:success] = "Comment Added!"
    else
      flash[:danger] = "Something went wrong!"
    end
    redirect_to post_comment_index_path
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
    @comment.destroy
    redirect_to post_comment_index_path
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
      if @comment.update(comment: params[:comment][:comment])
        flash[:notice] = "Comment updated!"
        redirect_to post_comment_index_path
      else
        flash[:danger] = "Something went wrong!"
        render :edit
      end
    end

  private
  def new_comment_params
    Comment.new(
    comment: params[:comment][:comment],
    user_id: current_user.id,
    post_id: params[:post_id]
    )
  end

end
