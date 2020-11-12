class ApplicationController < ActionController::Base
  before_action :initialize_session

  private

  def initialize_session
    session[:items] ||= []
    if session[:cart]
      @cart = Cart.find(session[:cart])
    else
      @cart = Cart.create
      session[:cart] = @cart.id
    end
  end

  def customer
    if session[:user_id]
      @customer = Customer.find(session[:user_id])
    end
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
