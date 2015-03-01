Feature: Validate sign up function

Scenario: Verify that error message is displayed when user do not input confirmation password
	Given user on home page
	When user open sign up account form 
	And user sign up without inputting confirmation password
	Then confirmation password error message displays