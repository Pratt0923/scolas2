class RoomsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    @chat_room = Room.find(params[:id])
    @message = Message.new
  	if correct_user(@chat_room)
  		@messages = @chat_room.messages
  	else
  		redirect_to root_url
  	end
  end

  def create
    @chat_room = Room.find(params[:id])
  	if @chat_room != nil && correct_user(@chat_room)
  		@chat_room.messages.new(message: params[:message], sender_name: current_user.email)
  	else
  		redirect_to root_url
  	end
  end

  private

    def not_found
      redirect_to root_url
      return
    end

  	def correct_user(room)
  		if current_user.id == room.seller_id || current_user.id == room.buyer_id
  			true
  		else
  			false
  		end
  	end
end