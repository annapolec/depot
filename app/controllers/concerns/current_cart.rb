module CurrentCart
	extend ActiveSupport::Concern #this method will be shared between controllers
				
	private	#private - prevents from making it available as an action on controller

		def set_cart
			@cart = Cart.find(session[:cart_id])  #find a Cart with cart_id
			rescue ActiveRecord::RecordNotFound #if cannot find it, creates new Cart and stores ID(of this new Cart)
												#into session
				@cart = Cart.create
				session[:cart_id] = @cart.id
		end
end
