class ItemsController < ApplicationController
  def index
    if params[:search]
      @search_term = params[:search]
      @type_id = params[:type_id].to_i
      @type = Type.find(@type_id) if @type_id != 0
      @search = true
      @items = Item.search_by(@search_term, @type_id).includes(:tag, :type, :variants).page params[:page]
    else
      @items = Item.includes(:tag, :type, :variants).order("name ASC").page params[:page]
    end
  end

  def show
    @item = Item.find(params[:id])
    @item_variants = []
    variants = @item.variants
    variants.each do |variant|
      @item_variants << ItemVariant.includes(:variant, :item).find_by(item: @item, variant: variant)
    end
    @variant_options = @item_variants.map { |option| [option.variant.name, option.id] }.to_h
  end
end
