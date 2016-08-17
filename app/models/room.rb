class Room < ActiveRecord::Base
	has_many :messages
	belongs_to :buyer  , class_name: "User"   , foreign_key: "buyer_id"
	belongs_to :seller , class_name: "User"   , foreign_key: "seller_id"
	belongs_to :listing , class_name: "Listing", foreign_key: "listing_id"

	def self.load_room(id)
		where(id: id).includes(:buyer, :seller, :listing)
	end
end
