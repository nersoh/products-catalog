require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def setup
  	@product = Product.new name: "name", description: "desc", status: :normal
  end

  test "product should be valid" do
  	assert @product.valid?
  end

  test "name should be present" do
    @product.name = " "
    assert_not @product.valid?
  end

  test "description should be present" do
    @product.description = " "
    assert_not @product.valid?
  end

  test "status should be featured" do
  	@product.status = :featured
  	assert @product.featured?
  end

  test "status should be 'normal' for non-given status" do
  	@product.status = ""
  	@product.save
  	assert @product.valid?
  	assert @product.normal?
  end
end
