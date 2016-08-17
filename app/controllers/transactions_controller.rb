class TransactionsController < ApplicationController
	before_action :authenticate_user!
	require 'securerandom'

	def create
		listing = Listing.find(params[:listing_id])
		check = false
		error_message = "Unable to purchase product"
		if listing != nil
			
			current_user.with_lock do
				if current_user.can_buy?(listing.price)

					chat_room = Room.new(seller_id: listing.user.id, buyer_id: current_user.id, listing_id: listing.id)
					chat_room.save

					chat_room.messages.create(message: params[:message], sender_name: current_user.email)
					
					transaction = Transaction.new(seller_id: listing.user.id,
												  buyer_id: current_user.id,
												  listing_id: listing.id,
												  points: listing.price,
												  serial_number: genereate_serial,
												  room_id: chat_room.id)

					current_user.withdraw(listing.price)
					listing.displayable = false

					check = listing.save
					check = current_user.save && check
					check = transaction.save && check
				else
					error_message = "You do not have enough point"
				end
			end
		end
		
		if check
			flash[:success] = "Successfully purchased product"
			redirect_to listings_url
		else
			flash[:danger] = error_message
			redirect_to listings_url(listing)
		end
	end

#
	def purchasing
	   @purchasing = current_user.purchasing_list
	end

	def sell
	   @sell = current_user.sell_list
	   @archive = Archive.new
	end

	def genereate_serial
		o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
		string = (0...6).map { o[rand(o.length)] }.join
	end
end