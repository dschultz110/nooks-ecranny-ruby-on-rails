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

  def cart
    item_variants = session[:items]
    @items = []
    item_variants.each do |variant|
      @items << ItemVariant.find(variant)
    end
  end

  def add_to_cart
    id = params[:id].to_i
    session[:items] << id unless session[:items].include?(id)
    redirect_to items_path
  end

  def remove_from_cart
    id = params[:id].to_i
    items = session[:items]

    # session[:items] = items.delete_if { |item| item[:item_variant_id] == id }
    # session[:items].delete(session[:items].select{|item| item[:item_variant_id] == id})
    session[:items].delete(id)
    redirect_to items_path
  end
end
