class CartPage < BasePage
	
	def initialize browser
		super
		$driver_wait.until {@browser.find_element(CART_POPUP)}
	end

	# Elements
	CART_POPUP = {css: 'div.nyroModalLink'}
	PRODCUT_DESC = {css: 'div.scrollable table td:nth-of-type(2) div.productdescription'}
	PRODUCT_PRICE = {css: 'div.scrollable table td:nth-of-type(3) span'}
	PRODUCT_QUANTITIES = {css: 'div.scrollable table td:nth-of-type(4) select'}


	# Methods

	def product_names_and_prices
		product_descriptions = @browser.find_elements(PRODCUT_DESC)
		temp_prices = @browser.find_elements(PRODUCT_PRICE)

		# remove 'VND' in price and remove white space 
		prices = temp_prices.collect { |p| p.text.gsub(/VND/,'').strip! } 

		# puts "product size is #{products.size}"
		products = Hash.new
		
		for i in 0..products.size
			products[product_descriptions[i].text] = prices[i]
		end

		products
	end

	def get_product_quantity(position = 1)
		temp_qty = @browser.find_elements(PRODUCT_QUANTITIES)
		quantities = temp_qty.collect {|e| e.text.to_i }
		quantities[position - 1]
	end

	def change_product_quantity(position,quantity)

		select_qty_locator = get_select_locator_at_column(position)
		select_dropdown(select_qty_locator,quantity)

	end

	private
	def get_select_locator_at_column(position)
		locator = "div.scrollable table:nth-of-type(#{position.to_i}) td:nth-of-type(4) select'"
		locator = "div.scrollable table:nth-of-type(1) td:nth-of-type(4) select"
		{css: locator}
	end

end




