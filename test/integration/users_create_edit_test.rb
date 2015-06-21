require 'test_helper'

class UsersCreateEditTest < ActionDispatch::IntegrationTest
  def setup
  	@admin = User.create(name: "admin", email: "admin@test.com",
  		password: 'password', password_confirmation: 'password', role: "admin")
    @user = User.create(name: "user", email: "user@test.com",
      password: 'password', password_confirmation: 'password', role: "user")
  end

  test "show user" do
    log_in_as @user
  	get user_path(@user)
  	assert_template 'users/show'
  	#assert_select 'p', @user.name
  end

  test "unsuccessful edit" do
    log_in_as @user
  	get edit_user_path(@user)
  	assert_template 'users/edit'

  	patch user_path(@user), user: {name: "", email: "invalid",
  		password: "sample", password_confirmation: "sample2"}
  	assert flash.empty?
  	assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as @user
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

  test "user should not edit other users" do
    log_in_as @user
    assert_redirected_to @user 
    get edit_user_path(@admin)
    assert_redirected_to root_url
    assert_not flash.empty?
    patch user_path(@admin), user: {name: "user"}
    @admin.reload
    assert_not_equal @admin.name, "user"
  end

  test "unauthorized user cannot create user" do
    log_in_as @user
    assert_redirected_to @user
    assert_no_difference "User.count" do
      post_via_redirect users_path, user: {name: "user", email: "user@email.com",
      password: 'name123', password_confirmation: 'name123'}
    end
    assert_not flash.empty?
  end

   test "authorized user can create user" do
    log_in_as @admin
    assert_redirected_to @admin
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name: "user", email: "user@email.com",
      password: 'name123', password_confirmation: 'name123'}
    end
    assert_not flash.empty?
  end

  test "admin users should edit other users" do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "newName"
    patch user_path(@user), user: {name: name}

    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, name
  end
end
