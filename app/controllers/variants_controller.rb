class VariantsController < ApplicationController
  def index
    @variants = Variant.all
  end

  def show
    @variant = Variant.find_by(name: params[:name])
  end
end
