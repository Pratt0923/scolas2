class Reply < ActiveRecord::Base
  belongs_to :comment
  validates_presence_of :content
end
