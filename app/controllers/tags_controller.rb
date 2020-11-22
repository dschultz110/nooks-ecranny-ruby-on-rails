class TagsController < ApplicationController
  def index
    @tags = Tag.all.order("name ASC")
  end

  def show
    @tag = Tag.find(params[:id])
    @items = @tag.items.page params[:page]
  end
end
