class VariantsController < ApplicationController
  def index
    @variants = Variant.all.order("name ASC")
  end

  def show
    @variant = Variant.find(params[:id])
    @items = @variant.items.paginate(:page => params[:page], per_page: 20)
  end
end
