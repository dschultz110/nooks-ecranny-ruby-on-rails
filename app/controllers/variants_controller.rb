class VariantsController < ApplicationController
  def index
    @variants = Variant.all
  end

  def show
    @variant = Variant.find(params[:id])
    @items = @variant.items.paginate(:page => params[:page], per_page: 20)
  end
end
