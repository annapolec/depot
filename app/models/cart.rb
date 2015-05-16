class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy #destroy -if we delete cart, associated line itimes will be destroyed
	
	
	#check if list of items icludes product we re adding
	#yes - increases quantity
	#no - builds new row in line_items table
	def add_product(product_id) #why methid in model? not in controller?
		current_item = line_items.find_by(product_id: product_id) #find_by returns one object, where return array
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id) #you could build it from "cart" side as well
																	#rails establishes connections for you
		end

		current_item
	end
	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end

