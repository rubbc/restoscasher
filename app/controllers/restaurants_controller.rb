class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:index, :show, :tagged]


  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant)
    @search = params["search"]
    if @search.present?
      @name = @search["name"]
      @restaurants = Restaurant.search(@name)
    else
      @restaurants = policy_scope(Restaurant).sample(6)
    end
    @all_restaurants = Restaurant.all
  end

  def show
    @related_restaurants = @restaurant.find_related_tags
  end

  def tagged
    if params[:tag].present?
      @restaurants = Restaurant.tagged_with(params[:tag])
    else
      @restaurants = Restaurant.all
    end

    authorize @restaurants
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

   def create
    @restaurant = current_user.restaurants.build(restaurant_params)
    authorize @restaurant

    if @restaurant.save
      @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
    # Unless @restaurant.valid?, #save will return false,
    # and @restaurant is not persisted.
    # TODO: present the form again with error messages.

  end


  def edit

  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end
  def restaurant_params
      params.require(:restaurant).permit(:name, :user_id, :address)
    end
end
