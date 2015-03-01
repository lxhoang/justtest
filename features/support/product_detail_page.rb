class ProductDetailPage < BasePage

	def initialize browser
		super
		$driver_wait.until {@browser.find_element(PRODUCT_TITLE)}
	end

	# Elements
	PRODUCT_TITLE = {id: 'prod_title'}
	PRICE = {css: 'div.prod_pricebox_price_final'}
	BTN_CART = {css: 'div.header__search__wrapper div'}
	BTN_ADD_PRODUCT = {id: 'AddToCart'}
	HEADER_LOGO = {css: 'img.header__logo__img'}

	# Methods
	def get_product_info
		description = @browser.find_element(PRODUCT_TITLE).text
		price = @browser.find_element(PRICE).text
		price.gsub!(/VND/,'').strip!
		info = {description => price}
	end

	def add_product_to_cart
		@browser.find_element(BTN_ADD_PRODUCT).click
		CartPage.new @browser		
	end

	def back_to_home_page
		@browser.find_element(HEADER_LOGO).click
		UnloggedHomePage.new @browser
	end

end