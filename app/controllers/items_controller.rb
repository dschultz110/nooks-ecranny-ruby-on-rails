class ItemsController < ApplicationController
  def index
    @items = Item.limit(50).includes(:tag, :type, :variants)
  end

  def show
    @item = Item.find(params[:id])
    @item_variants = []
    variants = @item.variants
    variants.each do |variant|
      @item_variants << ItemVariant.includes(:variant, :item).find_by(item: @item, variant: variant)
    end
    @variant_options = @item_variants.map { |option| [option.variant.name, option.id ]}.to_h
  end
end
