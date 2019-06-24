class ItemsController < ApplicationController


  before_action :set_restaurant, only: [ :index, :show, :edit, :update, :destroy]

  def index
    @items = policy_scope(Item)
    # @items = @restaurant.items.all
  end

  def show
    @item = @restaurant.items.find(params[:id])
  end

  def new
    # we need @restaurant in our `simple_form_for`
    @restaurant = Restaurant.find(params[:restaurant_id])
    @item = Item.new
    authorize @restaurant
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
    authorize @restaurant
  end


  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end



  def item_params
    params.require(:item).permit(:name, :price, :description, :category)
  end
end
