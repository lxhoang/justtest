Feature: Validate product information: description, price, subtotal, quantity in cart popup
	
	Background: 
		Given user on home page

	Scenario: Verify that product information in product detail page and cart page is the same
		When user navigate to product detail page
		And user add product to cart from detail page
		Then information of product in both product detail page and cart page should be the same

	Scenario: Verify that subtotal is updated after changing product quantity
		And user add product to cart
		Then quantity of cart product should be '1'
		When user change quantity of cart product to '2'
		Then subtotal price will increase '2' times

	Scenario: Verify that subtotal is updated after changing product quantity when cart has many items
		Given user add some products to cart
		When user changes quantity of any product
		Then the subtotal is updated properly according to changes

	