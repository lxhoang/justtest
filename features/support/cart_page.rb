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
	SUCESS_UPDATE_MESS = {css: 'div.fullMessenger div.pas'}
	SUBTOTAL_PRICE = {css: 'div#subtotal td:nth-of-type(3)'}
	CLOSE_BUTTON = {css: "a[title='close']"}
	CART_COLUMN = {css: 'div.scrollable table'}

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
		# define select by position of product (product column)
		temp_qty = @browser.find_element({css: "div.scrollable table:nth-of-type(#{position}) td:nth-of-type(4) select"})
		select_list = Selenium::WebDriver::Support::Select.new(temp_qty)
		select_list.first_selected_option.text.to_i
	end

	def change_product_quantity(position,quantity)
		select_locator = product_quantity_dropdown(position)
		select_dropdown(select_locator,quantity)	
		sleep 1
		# wait until success message displays
		$driver_wait.until { @browser.find_element(SUCESS_UPDATE_MESS).text.match("Đã cập nhật giỏ hàng") }
	end

	def get_product_price_on_position(position = 1)
		locator = "div.scrollable table:nth-of-type(#{position}) td:nth-of-type(3) span"
		price = @browser.find_element(css: locator).text.gsub(/VND/,'')
		price.to_f
	end

	def subtotal_price
		subtotal = @browser.find_element(SUBTOTAL_PRICE).text
		subtotal = subtotal.gsub(/VND/,'').to_f
	end

	def close
		@browser.find_element(CLOSE_BUTTON).click
		ProductDetailPage.new @browser
	end

	def calculate_subtotal
		num_column = @browser.find_elements(CART_COLUMN).size
		puts "num column is #{num_column}"
		subtotal = 0

		for i in 1..num_column
			price = get_product_price_on_position(i)
			qty = get_product_quantity(i)
			subtotal += price*qty
		end
		subtotal
	end

    private
	def product_quantity_dropdown(position)
		locator = "div.scrollable table:nth-of-type(#{position}) td:nth-of-type(4) select"
		{css: locator}
	end

end