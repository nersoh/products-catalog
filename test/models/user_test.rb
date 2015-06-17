require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "nelson", email: "nelson@test.com",
										 password: "password", password_confirmation: 'password')
	end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "x" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "x" * 250 << "@test.com"
  	assert_not @user.valid?
  end

  test "email should be valid" do
  	@user.email = "test@test"
  	assert_not @user.valid?
  end

  test "password should not match" do
  	@user.password = @user.password_confirmation = "x" * 5
  	assert_not @user.valid?
  end
end
