class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
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
    (user == post.user)
  end

  def edit?
    user == post.user
  end

  def update?
    edit?
  end
end
