class VariantsController < ApplicationController
  def index
    @variants = Variant.all
  end

  def show
    @variant = Variant.find(params[:id])
  end
end
