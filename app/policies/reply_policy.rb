class ReplyPolicy < ApplicationPolicy
  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    user.id == post.comment.user_id
  end

  def edit?
    user.id == post.comment.user_id
  end

  def update?
    edit?
  end
end
