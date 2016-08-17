class MessagesController < ApplicationController
	before_action :authenticate_user!
	
	def create
		chat_room = Room.find(params[:room_id])
		if chat_room != nil && correct_user(chat_room)
			message = chat_room.messages.create(message: params[:message][:message], sender_name: current_user.name)
			redirect_to room_url(chat_room)
		end
	end

	private

	  	def correct_user(room)
	  		if current_user.id == room.seller_id || current_user.id == room.buyer_id
	  			true
	  		else
	  			false
	  		end
	  	end
end