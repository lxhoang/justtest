When(/^user navigate to product detail page$/) do
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  @product_detail_page = @laptop_page.select_first_product
  @product_info = @product_detail_page.get_product_info
end

Then(/^information of product in both product detail page and cart page should be the same$/) do
  @product_cart_info = @cart_page.product_names_and_prices
  assert_equal(@product_cart_info,@product_info)
end

When(/^user add product to cart from detail page$/) do
  @cart_page = @product_detail_page.add_product_to_cart
end

Given(/^user add product to cart$/) do
  chosen_product = 1
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  @product_detail_page = @laptop_page.select_product(chosen_product)
  @product_info = @product_detail_page.get_product_info
  @cart_page = @product_detail_page.add_product_to_cart
end

Then(/^quantity of cart product should be '(\d+)'$/) do |default_quantity|
  assert_equal(default_quantity.to_i,@cart_page.get_product_quantity)
  @product_position = 1
  @price = @cart_page.get_product_price_on_position(@product_position)
end

When(/^user change quantity of cart product to '(\d+)'$/) do |quantity|
  @cart_page.change_product_quantity(@product_position,quantity)
end

Then(/^subtotal price will increase '(\d+)' times$/) do |times|
  price = @cart_page.get_product_price_on_position(@product_position)
  quantity = @cart_page.get_product_quantity(@product_position)
  subtotal = @cart_page.subtotal_price
  assert_equal(subtotal, price*quantity)
end

Given(/^user add some products to cart$/) do
  product_one = 2
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  @product_detail_page = @laptop_page.select_product(product_one)
  @cart_page = @product_detail_page.add_product_to_cart

  product_two = 3
  @product_detail_page = @cart_page.close
  @page = @product_detail_page.back_to_home_page
  @desktop_laptop_page = @page.select_sidebar_laptop
  @laptop_page = @desktop_laptop_page.select_category_laptop
  @product_detail_page = @laptop_page.select_product(product_two)
  @cart_page = @product_detail_page.add_product_to_cart
end

When(/^user changes quantity of any product$/) do
  @cart_page.change_product_quantity(1,2)  
  @cart_page.change_product_quantity(2,3)
end

Then(/^the subtotal is updated properly according to changes$/) do
  expected_subtotal = @cart_page.calculate_subtotal
  subtotal = @cart_page.subtotal_price
  assert_equal(expected_subtotal,subtotal)
end




