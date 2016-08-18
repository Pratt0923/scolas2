class PostController < ApplicationController
  def index
    @posts = current_user.posts
  end

  def new
    @interests_array = []
    JSON.parse(current_user.interests).each do |f|
      if Subject.find(f)
        @interests_array.push(Subject.find(f))
      end
    end
    @interests_array
  end

  def show
    @signed_ins_posts = current_user.posts
  end

  def create
    new_post
    @post.save!
    redirect_to post_index_path
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to post_index_path
  end

  def edit
    @post = Post.find(params[:id])
    @interests_array = []
    @interests = JSON.parse(current_user.interests).each do |f|
      if Subject.find(f)
        @interests_array.push(Subject.find(f))
      end
    end
  end

  def update
    @post = Post.find params[:id]
    @subject = Subject.find(params[:post][:subject])
    authorize @post
    subject_update_details
  end

  private
  def new_post
    @subject = Subject.find(params[:post][:subject]).id
    @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      subject_id: @subject
      )
    @post.user_id = current_user.id
  end

  def subject_update_details
    if @post.update(
        title: params[:post][:title],
        content: params[:post][:content],
        subject_id: @subject.id
        )
      flash[:notice] = "Post updated!"
      redirect_to post_index_path
    else
      render :edit
    end
  end
end
