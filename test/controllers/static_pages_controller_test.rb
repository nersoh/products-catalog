require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

	def setup
		@base_title = "Sample Store"
	end

  test "should get home" do
    get :home
    assert_select "title", @base_title
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_select "title", "About" + " | " + @base_title
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_select "title", "Contact" + " | " + @base_title
    assert_response :success
  end
end
