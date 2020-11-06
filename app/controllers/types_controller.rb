class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def name
    @type = Type.find_by(name: params[:name])
  end
end
