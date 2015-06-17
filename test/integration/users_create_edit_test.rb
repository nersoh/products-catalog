require 'test_helper'

class UsersCreateEditTest < ActionDispatch::IntegrationTest
  def setup
  	@user = User.create(name: "test", email: "test@test.com",
  											password: 'password', password_confirmation: 'password')
  end

  test "show user" do
  	get user_path(@user)
  	assert_template 'users/show'
  	#assert_select 'p', @user.name
  end

  test "unsuccessful edit" do
  	get edit_user_path(@user)
  	assert_template 'users/edit'

  	patch user_path(@user), user: {name: "", email: "invalid",
  																 password: "sample", password_confirmation: "sample2"}
  	assert flash.empty?
  	assert_template 'users/edit'
  end

  test "successful edit" do
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	name = "name1"
  	email = "email@email.com"
  	patch user_path(@user), user: {name: name, email: email,
  																			password: 'name123', password_confirmation: 'name123'}
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal @user.name, name
  	assert_equal @user.email, email
  end

end
