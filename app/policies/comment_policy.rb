class CommentPolicy < ApplicationPolicy
  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def destroy?
    user.id == @comment.user_id
  end

  def edit?
    user.id == @comment.user_id
  end

  def update?
    edit?
  end
end
