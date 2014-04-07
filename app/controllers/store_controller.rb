class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)#получение заголовков
  end
end
