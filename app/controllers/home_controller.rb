class HomeController < ApplicationController
  def index
    @items = Item.limit(5).includes(:tag, :type, :variants)
  end

  def cart

  end
end
