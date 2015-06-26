class Admin::DashboardController < ApplicationController
	before_action :logged_in_user
  def index
  	@products = Product.last(5)
  	@users = User.last(5)
  end
end
