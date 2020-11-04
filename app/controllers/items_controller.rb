class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(name: params[:name])
    @variants = []
    variants = @item.variants
    variants.each do |variant|
      @variants << ItemVariant.find_by(item: @item, variant: variant)
    end
  end
end
