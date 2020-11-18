class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email password province_id])
  end

  private

  def initialize_session
    session[:items] ||= []
    if session[:cart]
      @cart = Cart.find(session[:cart])
    else
      @cart = Cart.create
      session[:cart] = @cart.id
    end

    @item_size = CartItem.where(cart: @cart).size
    types = Type.all.map { |option| [option.name, option.id] }.to_h
    @type_options = { 'Any Type': 0 }.merge(types)
    @provinces = Province.all.map { |option| [option.name, option.id] }.to_h
  end

  def customer
    @customer = Customer.find(session[:user_id]) if session[:user_id]
  end

  def cart
    # if login?
    #   @cart = @customer.cart
    # else
    if session[:cart]
      @cart = Cart.find(session[:cart])
    else
      @cart = Cart.create
      session[:cart] = @cart.id
    end
    # end
  end

  def login?
    !!customer
  end

  def authenticated?
    # redirect_to login_path unless login?
  end
end
