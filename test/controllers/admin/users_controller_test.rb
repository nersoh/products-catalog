require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @admin = User.create(name: "admin", email: "admin@test.com",
      password: 'password', password_confirmation: 'password', role: "admin")
    @user = User.create(name: "user", email: "user@test.com",
      password: 'password', password_confirmation: 'password', role: "user")
    login_for_test @user
  end

  test "should get index" do
  	login_for_test @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
  	login_for_test @admin
    get :new
    assert_response :success
  end

  test "should create user" do
  	login_for_test @admin
    assert_difference('User.count') do
      post :create, user: { email: "email2@user.email", name: "user2",
        password: 'password', password_confirmation: 'password' }
    end

    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should show user" do
  	login_for_test @admin
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
  	login_for_test @admin
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
  	login_for_test @admin
    patch :update, id: @user, user: { email: @user.email, name: @user.name }
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should destroy user" do
  	login_for_test @admin
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to admin_users_path
  end

  test "unauthorized user should not change user roles" do
  	login_for_test @user
  	patch :update, id: @user, user: {role: "admin"}
  	@user.reload
  	assert_not @user.admin?
  end
end
