require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest

	def setup
		@default_product_image = "/no_product_image.gif"
    @user = User.create(name: "admin", email: "admin@test.com",
                        password: 'password', password_confirmation: 'password', role: "admin")
    log_in_as @user
	end

  test "unsuccessful create" do
    assert_no_difference "Product.count" do
    	post_via_redirect admin_products_path, product: {name: "p1"}
    end
    assert_template 'admin/products/new'
  end

  test "successful create" do
    assert_difference "Product.count", 1 do
    	post_via_redirect admin_products_path, product: {name: "p1", description: "desc"}
    end
    assert_template 'admin/products/show'
    assert_select "img[src=?]", @default_product_image
  end
end
