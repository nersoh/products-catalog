require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
	setup do 
		@user = User.create(name: "admin", email: "admin@test.com",
      password: 'password', password_confirmation: 'password', role: "admin")
	end
  test "should get index" do
  	login_for_test @user
    get :index
    assert_response :success
  end

  test "non-user should be redirected to login" do 
  	get :index
  	assert_redirected_to login_url
  end

end
