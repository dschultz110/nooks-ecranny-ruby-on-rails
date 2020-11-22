class VariantsController < ApplicationController
  def index
    @variants = Variant.all.order("name ASC")
  end

  def show
    @variant = Variant.find(params[:id])
    @items = @variant.items.page params[:page]
  end
end
