class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def show
    @type = Type.find_by(name: params[:name])
  end
end
