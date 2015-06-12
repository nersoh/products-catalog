class StaticPagesController < ApplicationController
  def home
  	@products_home = {
  		:featured => Product.featured,
  		:newer => Product.newer,
  		:normal => Product.normal,
  	}
  end

  def about
  end

  def contact
  end
end
