class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @items = @tag.items.paginate(:page => params[:page], per_page: 20)
  end
end
