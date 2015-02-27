Feature: Validate cart product information 

	Scenario: Validate product information between product detail page and cart page
	Given user on unlogged home page
	And cart is empty	
	When user navigate to product detail page
	And add product to cart
	Then information of product in both product detail page and cart page should be the same

	Scenario: 


