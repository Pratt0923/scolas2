class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  has_many :listings, dependent: :destroy

  has_many :purchasing, class_name: "Transaction", foreign_key: "buyer_id", dependent: :destroy
  has_many :sell, class_name: "Transaction", foreign_key: "seller_id", dependent: :destroy


  has_many :purchased, class_name: "Archive", foreign_key: "buyer_id", dependent: :destroy
  has_many :sales, class_name: "Archive", foreign_key: "seller_id", dependent: :destroy

  has_many :selling_rooms, class_name: "Room", foreign_key: "seller_id", dependent: :destroy
  has_many :buying_room, class_name: "Room", foreign_key: "buyer_id", dependent: :destroy

  has_many :comments, through: :posts
  has_many :posts


  def can_buy?(listing_price)
  	if self.points >= listing_price
  		true
  	else
      false
 	end
  end

  def withdraw(listing_price)
  	self.points -= listing_price
  end


  def purchasing_list
    purchasing.includes(:seller, :listing)
  end

  def purchased_list
    purchased.includes(:seller, :listing)
  end

  def sell_list
    sell.includes(:seller, :listing)
  end

  def sales_list
    sales.includes(:seller, :listing)
  end
end
