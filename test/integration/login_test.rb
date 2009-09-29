require 'test_helper'

class LoginTest < ActionController::IntegrationTest

  test "login with valid data" do
    visit new_user_session_url
    fill_in "user_session[email]", :with => "test_user@example.com"
    fill_in "user_session[password]", :with => "secret"
    click_button "user_session_submit"
    #assert_equal current_user.id, session[:user], "Should have been logged in" 
    #assert true
  end
  
  test "edit user profile" do
    person = User.find(1)
    visit edit_user_path(person)
  end  
  
end
