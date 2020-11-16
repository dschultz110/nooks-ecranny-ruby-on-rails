class HomeController < ApplicationController
  def index
    @items = Item.limit(5).includes(:tag, :type, :variants)
    new_range = Time.now - 5.day
    updated = Time.now - 1.hour
    @new_items = Item.where(["created_at >= ? AND updated_at <= ?", new_range, updated]).limit(4)
    @updated_items = Item.where(["updated_at >= ? AND created_at <= ?", updated, updated]).limit(4)
  end
end
