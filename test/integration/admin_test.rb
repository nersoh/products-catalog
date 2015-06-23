require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  setup do
  	@user = User.create(name: "admin", email: "admin@test.com",
      password: 'password', password_confirmation: 'password', role: "admin")
  end

  test "access to dashboard" do
  	log_in_as @user
  	assert_redirected_to admin_url
  end

  test "denied access when not logged in" do
  	get admin_path
  	assert_redirected_to login_url
  end
end
