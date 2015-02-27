Given(/^user on unlogged home page$/) do
  @page = UnloggedHomePage.new @browser
  @page.go_to_home_page
end

When(/^user open sign up account form$/) do
  @page.open_sign_up_form
end

When(/^user sign up without inputting confirmation password$/) do
  @page.fill_register_name("example")
  @page.fill_register_email("example@email.com")
  @page.fill_register_password("example")
  @page.select_DOB("1987",'April','04')
  @page.submit_register_form
end

Then(/^confirmation password error message displays$/) do
  @page.verify_confirm_password_message_displays('Mật khẩu phải có ít nhất 1 chữ số')
end

Given(/^cart is empty$/) do
  #pending
end

When(/^user navigate to product detail page$/) do
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  @product_detail_page = @laptop_page.select_first_product
  @product_info = @product_detail_page.get_product_info
end

When(/^add product to cart$/) do
  @cart_page = @product_detail_page.add_product_to_cart
end

Then(/^information of product in both product detail page and cart page should be the same$/) do
  @product_cart_info = @cart_page.product_names_and_prices
  assert_equal(@product_cart_info,@product_info)
end

Given(/^user open homepage and add product to cart$/) do
  @page = UnloggedHomePage.new @browser
  @page.go_to_home_page
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  # will change later
  # @product_detail_page = @laptop_page.add_random_product_to_cart
  @product_detail_page = @laptop_page.select_first_product
  @cart_page = @product_detail_page.add_product_to_cart
end

Then(/^quantity of cart product should be '(\d+)'$/) do |default_quantity|
  assert_equal(default_quantity.to_i,@cart_page.get_product_quantity)
end

When(/^user change quantity of cart product to '(\d+)'$/) do |quantity|
  @subtotal = @cart_page.get_subtotal
  @cart_page.change_product_quantity(1,quantity)
end

Then(/^subtotal price will increase '(\d+)' times$/) do |times|
  
  # assert_equal(expected,actual)

end





