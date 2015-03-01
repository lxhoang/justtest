Given(/^user on home page$/) do
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