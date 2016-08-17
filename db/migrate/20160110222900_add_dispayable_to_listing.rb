class AddDispayableToListing < ActiveRecord::Migration
  def change
  	add_column :listings, :displayable, :boolean, default: true
  end
end