class LaptopPage < BasePage
	
	def initialize browser
		super
		$driver_wait.until { @browser.current_url.include?'http://www.lazada.vn/laptop/'}
	end

	# Elements
	FIRST_PRODUCT = {xpath: "//div[@class='catalog__main__content']/div[2]/a"}

	# Methods
	def select_first_product
		@browser.find_element(FIRST_PRODUCT).click
		ProductDetailPage.new @browser
	end

	def method_name
		
	end

end