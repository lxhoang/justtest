class BasePage
	
	attr_reader :browser
	
	def initialize browser
		@browser = browser

		# set implicit wait for selenium driver
		@browser.manage.timeouts.implicit_wait = 10 # seconds

		$driver_wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
	end

	def select_dropdown(locator, item)
		begin
			dropdown = @browser.find_element(locator)
			dropdown_list = Selenium::WebDriver::Support::Select.new(dropdown)
			dropdown_list.select_by(:text, item)
		rescue Exception => e
			raise "Cannot select item of dropdown caused by #{e.message}"
		end
	end

end
