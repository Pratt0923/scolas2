class Message < ActiveRecord::Base
	belongs_to :room, counter_cache: true

	validates :message, presence: true, length: { maximum: 1000 }
end
