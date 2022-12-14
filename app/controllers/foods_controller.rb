class FoodsController < ApplicationController
  def index
    @foods = Food.all
    @food = Food.new
  end

  def create
    food = Food.new(food_params);
    food.user = User.first
    if food.save
      flash[:message] = "Food created successfully"
    else
      flash[:message] = "Food wasn't create"
    end
    redirect_to foods_path
  end

  def destroy
    food = Food.find(params[:id])

    if food.destroy
      flash[:message] = "Food deleted"
    else
      flash[:message] = "Food could not be deleted"
    end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
