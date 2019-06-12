class RestaurantsController < ApplicationController
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
end
