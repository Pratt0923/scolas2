class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :subject
  validates_presence_of :content, :title
end
