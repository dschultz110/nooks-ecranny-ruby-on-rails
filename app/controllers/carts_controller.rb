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
    @quantity = params[:quantity].to_i

    cart = Cart.find(session[:cart])
    variant = ItemVariant.find(@selected_variant)

    cart_item = CartItem.find_by(cart: cart, item_variant: variant)
    if cart_item.nil?
      CartItem.create(cart: cart, item_variant: variant, quantity: @quantity)
    else
      cart_item.quantity += @quantity
      cart_item.save
    end

    # session[:selected_variant] = @selected_variant
    # session[:selected_quantity] = @quantity

    redirect_to item_path(variant.item.id)
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
    cart = session[:cart]
    item_variant = ItemVariant.find(id)
    CartItem.find_by(item_variant: item_variant, cart_id: cart).delete
    redirect_to cart_path
  end

  def update_cart
    id = params[:id].to_i
    item_variant = ItemVariant.find(id)
    cart = session[:cart]
    item = CartItem.find_by(item_variant: item_variant, cart_id: cart)
    item.quantity = params[:quantity].to_i
    item.save

    redirect_to cart_path
  end
end
