class TypesController < ApplicationController
  def index
    @types = Type.all.order("name ASC")
  end

  def name
    @type = Type.find_by(name: params[:name])
    @items = @type.items.paginate(:page => params[:page], per_page: 20)
  end
end
