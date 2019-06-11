class ItemsController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @restaurant = Restaurant.find(params[:restaurant_id])
    @item = Item.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @item = Item.new(item_params)
    # we need `restaurant_id` to asssociate item with corresponding restaurant
    @item.restaurant = Restaurant.find(params[:restaurant_id])
    if @item.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category)
  end
end
