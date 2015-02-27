class UnloggedHomePage < BasePage

	def initialize browser
		super
	end

	# Attributes
	def url
		url = 'http://lazada.vn'		
	end	

	def expected_title
		"Mua hàng Trực tuyến Giá rẻ - Mua hàng trên Lazada Việt Nam"
	end

	# Web Elements
	SIGN_UP_LINK = {css: '.header__navigation > li:nth-child(5)'}
	SIGN_UP_TAB = {css: "label.option-label[for='tab-input-2']"}

	REGIS_NAME = {id: 'RegistrationForm_first_name'}
	REGIS_EMAIL = {id: 'RegistrationForm_email'}
	REGIS_PASS = {id: 'RegistrationForm_password'}
	REGIS_CONFIRM_PASS = {id: 'RegistrationForm_password2'}
	REGIS_YEAR = {id: 'RegistrationForm_year'}
	REGIS_MONTH = {id: 'RegistrationForm_month'}
	REGIS_DAY = {id: 'RegistrationForm_day'}
	REGIS_GENDER = {id: 'RegistrationForm_gender'}
	REGIS_SUBMIT = {id: 'send'}
	REGIS_CONFIRM_PASSWORD_MESSAGE = {css: 'input#RegistrationForm_password2 ~ span'}

	SIDEBAR_LIST = {css: 'ul.sidebar__list > li'}


	# Methods
	def go_to_home_page
		@browser.navigate.to url
		raise 'User is not redirected to expected lazada home page'	unless @browser.title.include?(expected_title)	
	end

	def open_sign_up_form
		@browser.find_element(SIGN_UP_LINK).click
		begin
			$driver_wait.until {@browser.find_element(SIGN_UP_TAB)}					
		rescue Exception => e
			raise "Sign Up Form cannot display"
		end
	end

	def fill_register_name name
		@browser.find_element(REGIS_NAME).send_keys name
	end

	def fill_register_email email
		@browser.find_element(REGIS_EMAIL).send_keys email
	end

	def fill_register_password pass
		@browser.find_element(REGIS_PASS).send_keys pass
	end

	def fill_register_confirm_password confirm_pass
		@browser.find_element(REGIS_CONFIRM_PASS).send_keys confirm_pass
	end	

	def select_DOB(year,month,day)
		select_dropdown(REGIS_YEAR,year)
		select_dropdown(REGIS_MONTH,month)
		select_dropdown(REGIS_DAY,day)
	end

	def submit_register_form
		@browser.find_element(REGIS_SUBMIT).click
	end

	def confirm_password_error_message
		@browser.find_element(REGIS_CONFIRM_PASSWORD_MESSAGE).text
	end

	def verify_confirm_password_message_displays(message)
		# confirm_password_error_message.should == message
		assert_equal(message,confirm_password_error_message)
	end

	def select_sidebar_laptop
		sidebar_list = @browser.find_elements(SIDEBAR_LIST)
		sidebar_list.each { |e| 
			if e.text.include?'MÁY VI TÍNH & LAPTOP'
				e.click
				break
			end
		}
		DesktopLaptopPage.new @browser
	end
	
end