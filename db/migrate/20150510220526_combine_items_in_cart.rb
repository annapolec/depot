class CombineItemsInCart < ActiveRecord::Migration
  
  #replace multiple items (with the same product) for a single row with correct quantity
  def up
  	Cart.all.each do |cart|
  		# count the number of each product in a cart
  		sums = cart.line_items.grouped_by(product_id).sum(quantity)

  		sums.each do |product_id, quantity|
  			if quantity > 1
  				# remove individual items
  				cart.line_items.where(product_id: product_id).delete_all

  				# replace with a single item with correct quantity
  				item = cart.line_items.build(product_id: product_id)
  				item.quantity = quantity
  				item.save!
  			end
  		end
  	end
  end

  def down
  	# split items with quantity>1 into multile items
  	LineItem.where("quantity>1") do |line_item|
  		# add individual items
  		line_item.quantity.times do

  			LineItem.create cart_id: line_item.cart_id,
  			product_id: line_item.product_id, quantity: 1
  	end
  	# remove original item
  	line_item.destroy
  end
end
