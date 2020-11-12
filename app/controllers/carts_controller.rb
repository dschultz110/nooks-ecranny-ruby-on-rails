class CartsController < ApplicationController
  def cart
    # item_variants = session[:items]
    # @item_variants = []
    # item_variants.each do |item_variant|
    #   @item_variants << ItemVariant.find(item_variant)
    # end
    cart = Cart.find(session[:cart])
    @cart_items = CartItem.where(cart: cart)


  end

  def add_to_cart
    @selected_variant = params[:variant].to_i
    session[:items] << @selected_variant unless session[:items].include?(@selected_variant)
    @quantity = params[:quantity]

    cart = Cart.find(session[:cart])
    variant = ItemVariant.find(@selected_variant)

    CartItem.create(cart: cart, item_variant: variant, quantity: @quantity)
    session[:selected_variant] = @selected_variant
    session[:selected_quantity] = @quantity

    redirect_to items_path
  end

  # def add_to_cart
  #   id = params[:id].to_i
  #   session[:items] << id unless session[:items].include?(id)
  #   redirect_to items_path
  # end

  def remove_from_cart
    id = params[:id].to_i
    # items = session[:items]

    # session[:items] = items.delete_if { |item| item[:item_variant_id] == id }
    # session[:items].delete(session[:items].select{|item| item[:item_variant_id] == id})
    session[:items].delete(id)
    item_variant = ItemVariant.find(id)
    CartItem.find_by(item_variant: item_variant).delete
    redirect_to cart_path
  end
end
