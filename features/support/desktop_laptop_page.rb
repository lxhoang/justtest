class DesktopLaptopPage < BasePage
	
	def initialize browser
		super
		$driver_wait.until {@browser.current_url.include?'http://www.lazada.vn/may-vi-tinh-laptop'}
	end

	# web elements
	LAPTOP = {id: 'out-mo1'}

	# methods
	def select_category_laptop
		@browser.find_element(LAPTOP).click
		LaptopPage.new @browser
	end

end