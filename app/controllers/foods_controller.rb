class FoodsController < ApplicationController
  def index
    @foods = Food.all
    @food = Food.new
  end

  def create
    food = Food.new(food_params)
    food.user = User.first
    flash[:message] = if food.save
                        'Food created successfully'
                      else
                        "Food wasn't create"
                      end
    redirect_to foods_path
  end

  def destroy
    food = Food.find(params[:id])

    flash[:message] = if food.destroy
                        'Food deleted'
                      else
                        'Food could not be deleted'
                      end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
