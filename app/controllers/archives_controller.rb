class ArchivesController < ApplicationController
	before_action :authenticate_user!
	def create
		trans = Transaction.find(params[:transaction_id])

		if trans != nil
			if correct_user(trans)
				if correct_seriel(trans)
					success = false
					seller = User.find(trans.seller_id)

					seller.transaction do
						seller.points += trans.points

						archive = Archive.new(seller_id: trans.seller_id,
										  buyer_id: trans.buyer_id,
										  listing_id: trans.listing_id,
										  points: trans.points,
										  serial_number: trans.serial_number,
										  room_id: trans.room_id)
						success = seller.save
						success = archive.save && success
						success = trans.destroy && success
					end

					if success
						flash[:success] = "Successfully Confirm Product Recive"
					else
						flash[:danger] = "Somthing went wrong"
					end

					redirect_to purchased_url
				else
					flash[:danger] = "Invalid Serial Number"
					redirect_to sell_url
				end
			else
				redirect_to root_url
			end
		else
			redirect_to root_url
		end
	end

	def purchased
		@purchased = current_user.purchased_list
	end

	def sales
		@sales = current_user.sales_list
	end

	private

		def correct_seriel(trans)
			if params[:archive][:serial_number].present? && trans.serial_number == params[:archive][:serial_number]
				true
			else
				false
			end
		end

		def correct_user(trans)
			if current_user.id == trans.seller_id
				true
			else
				false
			end
		end
end
