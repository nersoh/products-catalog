require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest

	def setup
		@default_product_image = "/no_product_image.gif"
	end
  test "unsuccessful create" do
    assert_no_difference "Product.count" do
    	post_via_redirect products_path, product: {name: "p1"}
    end
    assert_template 'products/new'
  end

  test "successful create" do
    assert_difference "Product.count", 1 do
    	post_via_redirect products_path, product: {name: "p1", description: "desc"}
    end
    assert_template 'products/show'
    assert_select "img[src=?]", @default_product_image
  end
end
