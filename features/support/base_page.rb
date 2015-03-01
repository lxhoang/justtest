class BasePage
	
	attr_reader :browser
	
	def initialize browser
		@browser = browser
		@browser.manage.window.maximize
		# set implicit wait for selenium driver
		@browser.manage.timeouts.implicit_wait = 10 # seconds

		$driver_wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
	end

	def select_dropdown(locator, item)
		dropdown = @browser.find_element(locator)
		options = dropdown.find_elements(tag_name: 'option')
		options.each { |option| option.click if option.text == item.to_s }

	end

end
