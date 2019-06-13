class RestaurantsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show, :tagged]
  def index
    @restaurants = Restaurant.all
    @search = params["search"]
    if @search.present?
      @name = @search["name"]
      @restaurants = Restaurant.search(@name)
    else
      @restaurants = Restaurant.all.sample(3)
    end

    @all_restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @related_restaurants = @restaurant.find_related_tags
  end

  def tagged
    if params[:tag].present?
      @restaurants = Restaurant.tagged_with(params[:tag])
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    @restaurant = Restaurant.new
  end

   def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      @restaurant.save
      redirect_to root_path
    else
      render :new
    end
    # Unless @restaurant.valid?, #save will return false,
    # and @restaurant is not persisted.
    # TODO: present the form again with error messages.

  end


  def restaurant_params
      params.require(:restaurant).permit(:name, :user_id)
    end
end
